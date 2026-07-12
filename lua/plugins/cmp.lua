-- ┌─────────────────────────────────────────┐
-- │  AUTOCOMPLETION                          │
-- └─────────────────────────────────────────┘
return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",     -- LSP completions
        "hrsh7th/cmp-buffer",       -- buffer words
        "hrsh7th/cmp-path",         -- file paths
        "saadparwaiz1/cmp_luasnip", -- snippets
        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets",
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
            snippet = {
                expand = function(args) luasnip.lsp_expand(args.body) end,
            },
            window = {
                completion    = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-Space>"] = cmp.mapping.complete(),           -- trigger suggestions
                ["<CR>"]      = cmp.mapping.confirm({ select = true }),
                ["<Tab>"]     = cmp.mapping(function(fallback)
                    if cmp.visible() then cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
                    else fallback() end
                end, { "i", "s" }),
                ["<S-Tab>"]   = cmp.mapping(function(fallback)
                    if cmp.visible() then cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then luasnip.jump(-1)
                    else fallback() end
                end, { "i", "s" }),
                ["<C-j>"]     = cmp.mapping.select_next_item(),
                ["<C-k>"]     = cmp.mapping.select_prev_item(),
                ["<C-d>"]     = cmp.mapping.scroll_docs(4),
                ["<C-u>"]     = cmp.mapping.scroll_docs(-4),
                ["<C-e>"]     = cmp.mapping.abort(),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp", priority = 1000 },
                { name = "luasnip",  priority = 750 },
                { name = "buffer",   priority = 500 },
                { name = "path",     priority = 250 },
            }),
        })
    end,
}
