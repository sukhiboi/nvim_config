return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      'nvim-neotest/neotest-jest'
    },
    config = function()
      local neotest = require("neotest")
      local jestCommand =
      "node --expose-gc --no-compilation-cache ./node_modules/jest/bin/jest.js --logHeapUsage --colors --silent"

      neotest.setup({
        icons = {
          expanded = "",
          child_prefix = "",
          child_indent = "",
          final_child_prefix = "",
          non_collapsible = "",
          collapsed = "",

          passed = " ",
          running = " ",
          failed = " ",
          unknown = " "
        },
        log_level = 3,
        discovery = {
          enabled = false,
        },
        adapters = {
          require('neotest-jest')({
            jestCommand = jestCommand,
            env = { CI = true },
            cwd = function()
              return vim.fn.getcwd()
            end,
          })
        }
      })

      vim.keymap.set('n', '<leader>tt', neotest.run.run)
      vim.keymap.set('n', '<leader>ta', neotest.run.attach)
      vim.keymap.set('n', '<leader>tf', function()
        neotest.run.run(vim.fn.expand("%"))
      end)
      vim.keymap.set('n', '<leader>ts', neotest.run.stop)
      vim.keymap.set('n', '<leader>tsu', neotest.summary.toggle)
      vim.keymap.set('n', '<leader>tl', neotest.run.run_last)
      vim.keymap.set('n', '<leader>tw', function()
        neotest.run.run({ jestCommand = jestCommand .. " --watch" })
      end)
    end
  },
  { "nvim-neotest/nvim-nio" }
}
