-- ┌─────────────────────────────────────────┐
-- │  GIT                                     │
-- └─────────────────────────────────────────┘
return {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPost",
    config = function()
        require("gitsigns").setup({
            current_line_blame = true,  -- inline git blame like IJ
        })
    end,
}
