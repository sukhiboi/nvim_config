-- ┌─────────────────────────────────────────┐
-- │  LSP (Language Servers)                  │
-- └─────────────────────────────────────────┘

-- IntelliJ-equivalent LSP keybindings, wired up whenever a server attaches.
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local opts = { buffer = ev.buf }
        local map = vim.keymap.set

        -- IntelliJ: Cmd+B → Go to definition
        map("n", "gd",         vim.lsp.buf.definition,      vim.tbl_extend("force", opts, { desc = "Go to definition" }))
        map("n", "<leader>gd", vim.lsp.buf.definition,      vim.tbl_extend("force", opts, { desc = "Go to definition" }))

        -- IntelliJ: Alt+Enter → Context actions / Quick fix
        map("n", "<leader>a",  vim.lsp.buf.code_action,     vim.tbl_extend("force", opts, { desc = "Code actions (Alt+Enter)" }))
        map("n", "<A-CR>",     vim.lsp.buf.code_action,     vim.tbl_extend("force", opts, { desc = "Code actions" }))

        -- IntelliJ: Shift+Shift → type info / hover
        map("n", "K",          vim.lsp.buf.hover,           vim.tbl_extend("force", opts, { desc = "Hover docs" }))

        -- IntelliJ: Cmd+P → parameter info
        map("i", "<C-p>",      vim.lsp.buf.signature_help,  vim.tbl_extend("force", opts, { desc = "Signature help" }))

        -- IntelliJ: Shift+F6 → Rename
        map("n", "<leader>rn", vim.lsp.buf.rename,          vim.tbl_extend("force", opts, { desc = "Rename symbol" }))

        -- IntelliJ: Alt+F7 → Find usages
        map("n", "gr",         vim.lsp.buf.references,      vim.tbl_extend("force", opts, { desc = "Find references" }))
        map("n", "<leader>u",  vim.lsp.buf.references,      vim.tbl_extend("force", opts, { desc = "Find usages" }))

        -- Go to implementation
        map("n", "gi",         vim.lsp.buf.implementation,  vim.tbl_extend("force", opts, { desc = "Go to implementation" }))

        -- Go to type definition
        map("n", "gt",         vim.lsp.buf.type_definition, vim.tbl_extend("force", opts, { desc = "Type definition" }))

        -- Diagnostics (like IJ error navigation)
        map("n", "]d",         vim.diagnostic.goto_next,    vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
        map("n", "[d",         vim.diagnostic.goto_prev,    vim.tbl_extend("force", opts, { desc = "Prev diagnostic" }))
        map("n", "<leader>D",  vim.diagnostic.open_float,   vim.tbl_extend("force", opts, { desc = "Line diagnostics" }))

        -- Format (like Cmd+Alt+L in IJ) — see lua/plugins/formatting.lua for <leader>lf
    end,
})

-- Note: mason-lspconfig >= 2.0 dropped `setup_handlers` in favor of Neovim
-- 0.11's native `vim.lsp.config()` / `vim.lsp.enable()`. Server setup below
-- uses that API instead of calling into `lspconfig[server].setup()`.
return {
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        config = function() require("mason").setup() end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        event = "BufReadPre",
        dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
        config = function()
            -- Applied to every server
            vim.lsp.config("*", {
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
            })

            -- Silence lua_ls "vim global" warnings
            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                        workspace   = { checkThirdParty = false },
                    },
                },
            })

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",       -- Lua
                    "ts_ls",        -- JavaScript/TypeScript/JSX/TSX
                    "pyright",      -- Python
                    "clangd",       -- C
                    "jsonls",       -- JSON
                    "yamlls",       -- YAML
                    "marksman",     -- Markdown
                    "sqlls",        -- SQL
                    "postgres_lsp", -- Postgres-specific SQL tooling
                    "eslint",       -- JS/TS project lint rules (alongside ts_ls)
                    "ruff",         -- Python linting (alongside pyright's type-checking)
                    "jdtls",        -- Java (managed manually via nvim-jdtls, see ftplugin/java.lua)
                },
                automatic_enable = {
                    exclude = { "jdtls" }, -- nvim-jdtls starts this one itself, per-project
                },
            })
        end,
    },
}
