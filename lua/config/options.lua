-- ── Core options ─────────────────────────────────────────────────────────────
local opt = vim.opt

opt.number         = true          -- line numbers
opt.relativenumber = true          -- relative line numbers (great for jumping)
opt.cursorline     = true          -- highlight current line
opt.signcolumn     = "yes"         -- always show sign column (no layout shift)
opt.termguicolors  = true          -- 24-bit color
opt.mouse          = "a"           -- mouse support
opt.clipboard      = "unnamedplus" -- system clipboard
opt.undofile       = true          -- persistent undo
opt.swapfile       = false         -- no swap files
opt.updatetime     = 200           -- faster CursorHold (snappier)
opt.timeoutlen     = 300           -- faster key sequence completion

-- search
opt.ignorecase = true
opt.smartcase  = true

-- indentation
opt.expandtab   = true
opt.shiftwidth  = 4
opt.tabstop     = 4
opt.smartindent = true

-- splits
opt.splitright = true
opt.splitbelow = true

-- scrolling
opt.scrolloff     = 8
opt.sidescrolloff = 8

-- completion menu
opt.completeopt = { "menu", "menuone", "noselect" }
opt.pumheight   = 12
