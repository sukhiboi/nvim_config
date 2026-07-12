-- =============================================================================
-- NEOVIM CONFIG — IntelliJ-like IDE experience
-- =============================================================================
-- Structure:
--   lua/config/keymaps.lua  → leader key, general keybindings, cheatsheet
--   lua/config/options.lua  → core vim options
--   lua/config/lazy.lua     → bootstraps lazy.nvim and loads lua/plugins/*.lua
--   lua/plugins/*.lua       → one file per feature/plugin
--
-- On first launch, lazy.nvim will auto-install all plugins.
-- After launch, run :Mason to install language servers you need.
-- =============================================================================

require("config.keymaps")
require("config.options")
require("config.lazy")
