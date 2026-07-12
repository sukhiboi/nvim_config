-- ┌─────────────────────────────────────────┐
-- │  MASON TOOLS (formatters, debug adapters)│
-- └─────────────────────────────────────────┘
-- mason-lspconfig's ensure_installed (lua/plugins/lsp.lua) only covers LSP
-- servers. Non-LSP tools like formatters and debug adapters go here.
return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    event = "VeryLazy",
    config = function()
        require("mason-tool-installer").setup({
            ensure_installed = {
                "stylua",             -- Lua formatter
                "prettier",           -- JS/TS/JSON/YAML/Markdown/HTML/CSS formatter
                "google-java-format", -- Java formatter
                "sql-formatter",      -- SQL formatter
                "js-debug-adapter",   -- JS/TS/Jest debugging
            },
        })
    end,
}
