-- ┌─────────────────────────────────────────┐
-- │  FUZZY FINDER (Telescope)                │
-- └─────────────────────────────────────────┘
return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    cmd = "Telescope",
    keys = {
        { "<leader>o",  "<cmd>Telescope find_files<CR>",  desc = "Find files       (Cmd+Shift+O)" },
        { "<leader>f",  "<cmd>Telescope live_grep<CR>",   desc = "Search in files   (Cmd+Shift+F)" },
        { "<leader>e",  "<cmd>Telescope oldfiles<CR>",    desc = "Recent files      (Cmd+E)" },
        { "<leader>b",  "<cmd>Telescope buffers<CR>",     desc = "Open buffers" },
        { "<leader>s",  "<cmd>Telescope lsp_document_symbols<CR>", desc = "File symbols" },
        { "<leader>S",  "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", desc = "Workspace symbols" },
        { "<leader>d",  "<cmd>Telescope diagnostics<CR>", desc = "All diagnostics" },
        { "<leader>/",  "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Search in buffer" },
        { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Git commits" },
        { "<leader>gb", "<cmd>Telescope git_branches<CR>",desc = "Git branches" },
    },
    config = function()
        local telescope = require("telescope")
        telescope.setup({
            defaults = {
                prompt_prefix   = "   ",
                selection_caret = "  ",
                sorting_strategy = "ascending",
                layout_config = { prompt_position = "top" },
                file_ignore_patterns = {
                    "node_modules", ".git/", "target/", "build/",
                    "%.class", "%.jar", "%.lock",
                },
            },
        })
        telescope.load_extension("fzf")
    end,
}
