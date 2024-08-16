return {
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    config = function()
      local lsp_zero = require('lsp-zero')

      lsp_zero.on_attach(function(client, bufnr)
        lsp_zero.default_keymaps({
          buffer = bufnr,
          exclude = { '<F4>' },
        })
        lsp_zero.buffer_autoformat()

        vim.keymap.set('n', '<C-s>', vim.lsp.buf.code_action)
      end)

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
      }

      require('mason').setup({})
      require('mason-lspconfig').setup({
        ensure_installed = {
          "stylua",
          "lua_ls",
          "gradle_ls",
          "html",
          "tsserver",
          "vimls",
          "yamlls",
          "rust_analyzer",
          "pyright",
          "postgres_lsp",
          "marksman",
          "kotlin_language_server",
          "java_language_server",
          "jdtls",
          "jsonls",
          "jqls",
          "groovyls",
          "eslint",
          "dockerls",
          "docker_compose_language_service",
          "bashls",
          "clojure_lsp",
          "gopls",
          "checkstyle"
        },
        handlers = {
          function(server_name)
            require('lspconfig')[server_name].setup({
              capabilities = capabilities
            })
          end,
          tsserver = {
            filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
            cmd = { "typescript-language-server", "--stdio" }
          }
        },
      })
      require('ufo').setup()
    end
  },
  { 'neovim/nvim-lspconfig' },
  { 'hrsh7th/cmp-nvim-lsp' },
  {
    'hrsh7th/nvim-cmp'
  },
  { 'L3MON4D3/LuaSnip' },
  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup()
    end
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    config = function()
      require('tiny-inline-diagnostic').setup()
    end
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async'
    },
    config = function()
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
    end
  }
}
