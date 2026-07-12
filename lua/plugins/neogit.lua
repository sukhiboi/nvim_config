-- ┌─────────────────────────────────────────┐
-- │  GIT PANEL (like IJ's Git tool window)   │
-- └─────────────────────────────────────────┘
return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
        "nvim-telescope/telescope.nvim",
    },
    cmd = "Neogit",
    keys = {
        { "<leader>gg", function() require("neogit").open() end, desc = "Git panel" },
    },
    config = function()
        require("neogit").setup({
            integrations = { telescope = true, diffview = true },
        })
    end,
}
