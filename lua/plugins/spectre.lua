-- ┌─────────────────────────────────────────┐
-- │  SEARCH & REPLACE across files           │
-- └─────────────────────────────────────────┘
return {
    "nvim-pack/nvim-spectre",
    keys = {
        { "<leader>r", function() require("spectre").open() end, desc = "Search & Replace (Cmd+Shift+R)" },
    },
}
