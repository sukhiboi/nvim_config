-- ┌─────────────────────────────────────────┐
-- │  STATUS LINE                             │
-- └─────────────────────────────────────────┘
return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
        require("lualine").setup({ options = { theme = "catppuccin-mocha" } })
    end,
}
