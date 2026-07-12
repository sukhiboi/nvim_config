-- ┌─────────────────────────────────────────┐
-- │  BUFFER TABS (like editor tabs)           │
-- └─────────────────────────────────────────┘
return {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        require("bufferline").setup({
            options = {
                -- Don't show the bufferline when only one file is open —
                -- this is what was rendering as a stray "tab" on startup.
                always_show_bufferline = false,
                diagnostics = "nvim_lsp",
                offsets = {{ filetype = "neo-tree", text = "Explorer", padding = 1 }},
                show_close_icon = false,
            },
        })
    end,
}
