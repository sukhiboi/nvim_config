return {
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {
        view = {
          side = 'right',
          width = 60
        },
        renderer = {
          highlight_git = true,
          indent_markers = {
            enable = true
          }
        },
        update_focused_file = {
          enable = true
        }
      }
      vim.keymap.set('n', '<C-q>', ':NvimTreeToggle<CR>', { noremap = true })
      vim.keymap.set('n', '<C-a>', ':NvimTreeFocus<CR>', { noremap = true })
    end,
  },
  {
    "nmac427/guess-indent.nvim",
    config = function()
      require('guess-indent').setup()
    end
  },
  {
    "Pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup()
    end
  },
  {
    "rmagatti/goto-preview",
    event = "BufEnter",
    config = function()
      local gotopreview = require("goto-preview")

      local jump_func = function(bufr)
        local function jump()
          gotopreview.close_all_win { skip_curr_window = false }
          vim.lsp.buf.definition()
        end

        vim.keymap.set("n", "<CR>", jump, {
          noremap = true,
          silent = true,
          buffer = bufr,
        })
      end

      gotopreview.setup {
        post_open_hook = function(bufr)
          jump_func(bufr)
        end,
      }

      vim.keymap.set('n', '<C-y>', gotopreview.goto_preview_definition)
      vim.keymap.set('n', 'gr', gotopreview.goto_preview_references)
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
  },
  {
    "VonHeikemen/fine-cmdline.nvim",
    dependencies = {
      'MunifTanjim/nui.nvim'
    },
  },
  {
    'stevearc/dressing.nvim',
    opts = {},
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  }
}
