-- Full Java + Spring Boot IDE setup, loaded per-buffer for filetype=java.
-- Wires jdtls together with the debug adapter, JUnit test runner, and the
-- Spring Boot Tools extension (bean navigation, application.properties
-- completion) the same way VS Code's Java/Spring extensions bundle them.

local ok, jdtls = pcall(require, "jdtls")
if not ok then return end

local mason_registry = require("mason-registry")
local function pkg_path(name)
    return mason_registry.get_package(name):get_install_path()
end

local root_dir = require("jdtls.setup").find_root({
    "gradlew", "mvnw", ".git", "pom.xml",
    "build.gradle", "build.gradle.kts", "settings.gradle", "settings.gradle.kts",
})
if root_dir == "" then return end

local project_name  = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls-workspace/" .. project_name

-- Pick the platform-specific launcher config that ships inside the jdtls package.
local uname = vim.loop.os_uname()
local config_dir
if uname.sysname == "Darwin" then
    config_dir = uname.machine == "arm64" and "config_mac_arm" or "config_mac"
elseif uname.sysname == "Linux" then
    config_dir = uname.machine == "aarch64" and "config_linux_arm" or "config_linux"
else
    config_dir = "config_win"
end

local jdtls_path = pkg_path("jdtls")

-- Extension bundles: debug adapter, JUnit test runner, Spring Boot Tools.
local bundles = {}
vim.list_extend(bundles, vim.split(vim.fn.glob(
    pkg_path("java-debug-adapter") .. "/extension/server/com.microsoft.java.debug.plugin-*.jar"), "\n"))
vim.list_extend(bundles, vim.split(vim.fn.glob(
    pkg_path("java-test") .. "/extension/server/*.jar"), "\n"))
vim.list_extend(bundles, vim.split(vim.fn.glob(
    pkg_path("vscode-spring-boot-tools") .. "/extension/jars/*.jar"), "\n"))
bundles = vim.tbl_filter(function(p) return p ~= "" end, bundles)

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local config = {
    cmd = {
        vim.fn.stdpath("data") .. "/mason/bin/jdtls",
        "-configuration", jdtls_path .. "/" .. config_dir,
        "-data", workspace_dir,
    },
    root_dir = root_dir,
    capabilities = capabilities,
    init_options = {
        bundles = bundles,
        extendedClientCapabilities = extendedClientCapabilities,
    },
    settings = {
        java = {
            signatureHelp = { enabled = true },
            completion = { favoriteStaticMembers = {
                "org.junit.Assert.*", "org.junit.jupiter.api.Assertions.*",
                "org.mockito.Mockito.*",
            } },
            -- Spring Boot Tools reads these to power bean/endpoint navigation.
            configuration = { updateBuildConfiguration = "automatic" },
        },
    },
    on_attach = function(_, bufnr)
        jdtls.setup_dap({ hotcodereplace = "auto" })
        require("jdtls.dap").setup_dap_main_class_configs()

        local map = vim.keymap.set
        local opts = { buffer = bufnr }

        -- IntelliJ: Ctrl+Alt+O → Organize imports
        map("n", "<leader>jo", jdtls.organize_imports, vim.tbl_extend("force", opts, { desc = "Organize imports" }))
        -- IntelliJ: Ctrl+Alt+V → Extract variable
        map("n", "<leader>jv", jdtls.extract_variable, vim.tbl_extend("force", opts, { desc = "Extract variable" }))
        map("n", "<leader>jc", jdtls.extract_constant, vim.tbl_extend("force", opts, { desc = "Extract constant" }))
        -- IntelliJ: Ctrl+Alt+M → Extract method (visual selection)
        map("v", "<leader>jm", function() jdtls.extract_method(true) end, vim.tbl_extend("force", opts, { desc = "Extract method" }))

        -- IntelliJ: Ctrl+Shift+F10 → Run test class / nearest test method
        map("n", "<leader>jtc", jdtls.test_class,          vim.tbl_extend("force", opts, { desc = "Test class (JUnit)" }))
        map("n", "<leader>jtm", jdtls.test_nearest_method, vim.tbl_extend("force", opts, { desc = "Test nearest method" }))
    end,
}

jdtls.start_or_attach(config)
