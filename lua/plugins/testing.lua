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
      neotest.setup({
        status = {
          virtual_text = true
        },
        log_level = 3,
        discovery = {
          enabled = false,
        },
        adapters = {
          require('neotest-jest')({
            jestCommand =
            "node --expose-gc --no-compilation-cache ./node_modules/jest/bin/jest.js --logHeapUsage --colors --silent",
            env = { CI = true },
            cwd = function()
              return vim.fn.getcwd()
            end,
          })
        }
      })

      vim.keymap.set('n', '<leader>tt', neotest.run.run)
      vim.keymap.set('n', '<leader>tf', function()
        neotest.run.run(vim.fn.expand("%"))
      end)
      vim.keymap.set('n', '<leader>ts', neotest.run.stop)
      vim.keymap.set('n', '<leader>tsu', neotest.summary.toggle)
      vim.keymap.set('n', '<leader>tl', neotest.run.run_last)
    end
  },
  { "nvim-neotest/nvim-nio" }
}
