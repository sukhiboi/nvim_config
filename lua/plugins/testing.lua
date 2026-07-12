-- ┌─────────────────────────────────────────┐
-- │  TEST RUNNER (Jest)                      │
-- └─────────────────────────────────────────┘
return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "haydenmeade/neotest-jest",
    },
    keys = {
        -- IntelliJ: Ctrl+Shift+F10 → Run nearest test
        { "<leader>tt", function() require("neotest").run.run() end, desc = "Run nearest test" },
        { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run file tests" },
        -- IntelliJ: Ctrl+Shift+F9 → Debug nearest test
        { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug nearest test" },
        { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Test summary panel" },
        { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Test output" },
        { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Test output panel" },
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-jest")({
                    jestCommand = "npx jest",
                    env = { CI = true },
                }),
            },
        })
    end,
}
