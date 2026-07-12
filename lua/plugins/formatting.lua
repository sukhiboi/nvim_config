-- ┌─────────────────────────────────────────┐
-- │  FORMATTING (like Cmd+Alt+L in IJ)       │
-- └─────────────────────────────────────────┘
return {
    "stevearc/conform.nvim",
    event = { "BufWritePre", "VeryLazy" },
    keys = {
        {
            "<leader>lf",
            function() require("conform").format({ async = true, lsp_fallback = true }) end,
            desc = "Format file",
        },
    },
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua        = { "stylua" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                json       = { "prettier" },
                yaml       = { "prettier" },
                markdown   = { "prettier" },
                html       = { "prettier" },
                css        = { "prettier" },
                python     = { "ruff_format" },
                java       = { "google-java-format" },
                sql        = { "sql_formatter" },
            },
            format_on_save = {
                timeout_ms = 2000,
                lsp_fallback = true,
            },
        })
    end,
}
