-- ┌─────────────────────────────────────────┐
-- │  JAVA / SPRING BOOT                      │
-- └─────────────────────────────────────────┘
-- The actual jdtls startup lives in ftplugin/java.lua (Neovim's native
-- per-filetype loading) since it needs per-project root/workspace detection
-- that lazy.nvim's generic plugin `config` hook isn't a good fit for.
return {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    dependencies = { "williamboman/mason.nvim" },
}
