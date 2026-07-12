-- ┌─────────────────────────────────────────┐
-- │  PROBLEMS PANEL (like IJ's Problems tool │
-- │  window)                                 │
-- └─────────────────────────────────────────┘
return {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
        { "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>",              desc = "Problems (workspace)" },
        { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Problems (current file)" },
        { "<leader>xq", "<cmd>Trouble qflist toggle<CR>",                   desc = "Quickfix list" },
    },
    opts = {},
}
