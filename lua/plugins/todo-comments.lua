-- ┌─────────────────────────────────────────┐
-- │  TODO COMMENTS (like IJ's TODO tool      │
-- │  window)                                 │
-- └─────────────────────────────────────────┘
return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "BufReadPost",
    keys = {
        { "]t",         function() require("todo-comments").jump_next() end, desc = "Next TODO" },
        { "[t",         function() require("todo-comments").jump_prev() end, desc = "Prev TODO" },
        { "<leader>xt", "<cmd>Trouble todo toggle<CR>",                       desc = "TODO list" },
    },
    config = function() require("todo-comments").setup() end,
}
