-- ┌─────────────────────────────────────────┐
-- │  AUTOPAIRS & SURROUND                    │
-- └─────────────────────────────────────────┘
return {
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function() require("nvim-autopairs").setup() end,
    },
    {
        "kylechui/nvim-surround",
        event = "BufReadPost",
        config = function() require("nvim-surround").setup() end,
    },
}
