-- ┌─────────────────────────────────────────┐
-- │  FILE EXPLORER (like Project panel)      │
-- └─────────────────────────────────────────┘
return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    keys = {
        { "<leader>t", "<cmd>Neotree toggle<CR>", desc = "File tree (Alt+1 in IJ)" },
    },
    config = function()
        require("neo-tree").setup({
            filesystem = {
                follow_current_file = { enabled = true },
                use_libuv_file_watcher = true,
            },
        })
    end,
}
