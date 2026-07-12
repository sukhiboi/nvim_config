-- ┌─────────────────────────────────────────┐
-- │  WHICH-KEY (discover keybindings)         │
-- └─────────────────────────────────────────┘
return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function() require("which-key").setup() end,
}
