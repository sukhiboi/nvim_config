-- ── Leader key ───────────────────────────────────────────────────────────────
-- Must be set before lazy.nvim/plugins load so <leader> keys resolve correctly.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- ── Buffer / Tab navigation ──────────────────────────────────────────────────
map("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next tab" })
map("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Prev tab" })
map("n", "<leader>x", "<cmd>bdelete<CR>",         { desc = "Close tab" })

-- ── Window navigation ────────────────────────────────────────────────────────
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- ── Quality of life ──────────────────────────────────────────────────────────
map("n", "<Esc>",    "<cmd>nohlsearch<CR>",             { desc = "Clear search highlight" })
map("v", "J",        ":m '>+1<CR>gv=gv",                { desc = "Move line down" })
map("v", "K",        ":m '<-2<CR>gv=gv",                { desc = "Move line up" })
map("n", "<C-d>",    "<C-d>zz",                         { desc = "Scroll down + center" })
map("n", "<C-u>",    "<C-u>zz",                         { desc = "Scroll up + center" })

-- ── Increment/decrement ──────────────────────────────────────────────────────
-- Vim's default <C-a>/<C-x> get eaten by tmux's prefix key (bound to Ctrl+a in
-- ~/.config/tmux/tmux.conf), so mirror them on <leader> too.
map({ "n", "v" }, "<leader>+", "<C-a>", { desc = "Increment number" })
map({ "n", "v" }, "<leader>-", "<C-x>", { desc = "Decrement number" })

-- ═════════════════════════════════════════════════════════════════════════════
-- CHEATSHEET — IntelliJ → Neovim mapping
-- ═════════════════════════════════════════════════════════════════════════════
--
--  IntelliJ              Neovim                 What it does
--  ─────────────────────────────────────────────────────────────────────
--  Alt+Enter             <Space>a  or  Alt+CR   Code actions / quick fix
--  Cmd+B                 gd                     Go to definition
--  Cmd+E                 <Space>e               Recent files
--  Cmd+Shift+O           <Space>o               Find files
--  Cmd+Shift+F           <Space>f               Search in all files
--  Cmd+Shift+R           <Space>r               Search & replace in files
--  Cmd+Alt+L             <Space>lf              Format file
--  Shift+F6              <Space>rn              Rename symbol
--  Alt+F7                <Space>u  or  gr       Find usages
--  Ctrl+W                Enter (normal mode)    Expand selection
--  Cmd+/                 gcc                    Toggle comment
--  Alt+1                 <Space>t               Toggle file tree
--  Ctrl+Tab              Shift+L / Shift+H      Next/prev tab
--  F2                    ]d                     Next error/warning
--  Cmd+P                 Ctrl+P (insert mode)   Parameter info
--  K (normal mode)       K                      Hover documentation
--  (n/a)                 <Space>+ / <Space>-    Increment/decrement number
--
-- ═════════════════════════════════════════════════════════════════════════════
