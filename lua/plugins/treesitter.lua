-- ┌─────────────────────────────────────────┐
-- │  SYNTAX HIGHLIGHTING (Treesitter)        │
-- └─────────────────────────────────────────┘
-- Note: nvim-treesitter's "main" branch (installed here) dropped the old
-- `configs.setup({ highlight = ..., indent = ... })` API. Highlighting/indent
-- are now native Neovim features that this plugin just supplies parsers for.
local langs = {
    "lua", "python", "javascript", "typescript", "tsx",
    "java", "kotlin", "go", "rust", "c", "cpp",
    "html", "css", "json", "yaml", "toml", "markdown",
    "bash", "dockerfile", "sql", "graphql", "xml", "http",
}

return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    config = function()
        require("nvim-treesitter").setup()
        require("nvim-treesitter").install(langs)

        vim.api.nvim_create_autocmd("FileType", {
            callback = function(ev)
                if not vim.tbl_contains(langs, ev.match) then return end

                vim.treesitter.start()
                vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}
