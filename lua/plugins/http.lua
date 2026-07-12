-- ┌─────────────────────────────────────────┐
-- │  HTTP CLIENT (.http files, like IJ's     │
-- │  HTTP Client)                            │
-- └─────────────────────────────────────────┘
return {
    "mistweaverco/kulala.nvim",
    ft = { "http", "rest" },
    keys = {
        { "<leader>hh", function() require("kulala").run() end,       desc = "Send HTTP request" },
        { "<leader>hn", function() require("kulala").jump_next() end, desc = "Next HTTP request" },
        { "<leader>hp", function() require("kulala").jump_prev() end, desc = "Prev HTTP request" },
    },
    opts = {},
}
