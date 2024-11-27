vim.g.mapleader = " "

-- Reload config
vim.keymap.set("n", "<leader><leader>", ":source %<CR>")

vim.keymap.set({ "n", "x" }, "<leader>w", "<Esc>:w<CR>")
vim.keymap.set("n", "<leader>x", ":q!<CR>")

-- Enable standard Ctrl+Backspace/Ctrl+Del behavior in insert mode
vim.keymap.set("i", "<C-Del>", "<C-o>dw")
vim.keymap.set("i", "<C-BS>", "<C-o>db")

-- Save file as sudo
vim.keymap.set("c", "w!!", "w !sudo tee > /dev/null %")

-- Toggle line wrap
vim.keymap.set("n", "gw", ":set wrap!<CR>")

-- Toggle relative line numbers
vim.keymap.set("n", "<leader>3", ":set relativenumber!<CR>")

-- Un-highlight search matches
vim.keymap.set("n", "<leader><Esc>", ":nohlsearch<CR>")
vim.keymap.set("x", "<leader><Esc>", "<Esc>:nohlsearch<CR>")

-- Use 'very magic' mode for search
--vim.keymap.set("n", "<leader>/", "/\v")
--vim.keymap.set("n", "<leader>?", "?\v")

-- Substitute word under cursor across entire file
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]])

-- Substite word under cursor once; use . to repeat
vim.keymap.set("n", "<leader>e", "*Ncgn")

-- Create horizontal split
--vim.keymap.set({ "n", "x" }, "<leader>h", "<Esc><C-w>s")
-- Create vertical split
vim.keymap.set({ "n", "x" }, "<leader>v", "<Esc><C-w>v")

-- Split navigation
vim.keymap.set({ "n", "x" }, "<Up>", "<Esc><C-W>k")
vim.keymap.set({ "n", "x" }, "<Down>", "<Esc><C-W>j")
vim.keymap.set({ "n", "x" }, "<Left>", "<Esc><C-W>h")
vim.keymap.set({ "n", "x" }, "<Right>", "<Esc><C-W>l")

-- Tab navigation
--vim.keymap.set("n", "<S-h>", "gT")
--vim.keymap.set("n", "<S-l>", "gt")

-- Center screen when paging up/down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "}", "}zz")
vim.keymap.set("n", "[[", "[[zz")
vim.keymap.set("n", "]]", "]]zz")
vim.keymap.set("n", "[]", "[]zz")
vim.keymap.set("n", "][", "][zz")
vim.keymap.set("n", "G", "Gzz")

-- Don't move cursor when searching with * or #
vim.keymap.set("n", "*", "*N")
vim.keymap.set("n", "#", "#N")

-- n/N always go forward/back regardless of how search was initiated
vim.keymap.set("n", "n", "/<CR>zz")
vim.keymap.set("n", "N", "?<CR>zz")

-- Paste while keeping current text in register
vim.keymap.set("x", "p", "\"_dP")

-- Delete to void register; preserves text currently in register
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("n", "<leader>D", "\"_D")
--vim.keymap.set("v", "<leader>d", "\"_d")

-- Make Y behave like C and D
vim.keymap.set("n", "Y", "y$")

-- Yank to system clipboard
vim.keymap.set({ "n", "x" }, "<leader>y", "\"+y")
vim.keymap.set({ "n", "x" }, "<leader>Y", "\"+y$")

-- Yank entire file to system clipboard
vim.keymap.set("n", "<C-y>", "mygg\"+yG`y")

-- Cut to system clipboard
vim.keymap.set("x", "<leader>x", "\"+x")

-- Paste from system clipboard
vim.keymap.set("n", "<leader>p", "\"+p")
vim.keymap.set("x", "<leader>p", "_d\"+P")
vim.keymap.set({ "c", "i" }, "<C-v>", "<C-R>+")

-- H/L go to start/end of line
vim.keymap.set({ "n", "o" }, "L", "$")
vim.keymap.set("n", "H", "0^")
vim.keymap.set("o", "H", "^")
vim.keymap.set("n", "^", "0^")

-- Move selected text up/down, reformat, then reselect (OG vim)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Don't move cursor when joining below line
vim.keymap.set("n", "J", "mzJ`z")

-- Split (opposite of J for join)
vim.keymap.set("n", "S", "yl/<C-r>0<CR>Ncgn<C-r>0<Del><CR><Esc>n:nohlsearch<CR>")

-- Reselect text after indenting/dedenting
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")
