vim.g.mapleader = " "

-- vim.keymap.set("n", "<leader><leader>", ":source %<CR>:nohlsearch<CR>", { silent = true, desc = "Reload config" })

vim.keymap.set({ "n", "x" }, "<leader>w", "<Esc>:w<CR>")
vim.keymap.set("n", "<leader>x", ":q!<CR>", { silent = true })

vim.keymap.set("c", "w!!", "w !sudo tee > /dev/null %", { desc = "Write file as sudo" })

vim.keymap.set("n", "gw", ":set wrap!<CR>", { silent = true, desc = "Toggle line wrap" })

vim.keymap.set("n", "<leader>3", ":set relativenumber!<CR>", { silent = true, desc = "Toggle relative line numbers" })

vim.keymap.set(
	{ "n", "x" },
	"<leader><Esc>",
	"<Esc>:nohlsearch<CR>",
	{ silent = true, desc = "Un-highlight search matches" }
)

-- Use 'very magic' mode for search
--vim.keymap.set("n", "<leader>/", "/\v")
--vim.keymap.set("n", "<leader>?", "?\v")

vim.keymap.set(
	"n",
	"<leader>s",
	[[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]],
	{ desc = "Substitute word under cursor across entire file" }
)

vim.keymap.set("n", "<leader>e", "*Ncgn", { desc = "Substite word under cursor once; use . to repeat" })

-- vim.keymap.set({ "n", "x" }, "<leader>h", "<Esc><C-w>s", { desc = "Create horizontal split" })
vim.keymap.set({ "n", "x" }, "<leader>v", "<Esc><C-w>v", { desc = "Create vertical split" })

-- Split navigation
vim.keymap.set({ "n", "x" }, "<Up>", "<Esc><C-W>k")
vim.keymap.set({ "n", "x" }, "<Down>", "<Esc><C-W>j")
vim.keymap.set({ "n", "x" }, "<Left>", "<Esc><C-W>h")
vim.keymap.set({ "n", "x" }, "<Right>", "<Esc><C-W>l")

-- Resize split
vim.keymap.set({ "n", "x" }, "<M-,>", "<C-w>5<")
vim.keymap.set({ "n", "x" }, "<M-.>", "<C-w>5>")
vim.keymap.set({ "n", "x" }, "<M-t>", "<C-w>+")
vim.keymap.set({ "n", "x" }, "<M-s>", "<C-w>-")

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
vim.keymap.set("x", "p", '"_dP')

-- Delete to void register; preserves text currently in register
vim.keymap.set({ "n", "x" }, "<leader>d", '"_d')
vim.keymap.set("n", "<leader>D", '"_D')

-- Make Y behave like C and D
vim.keymap.set("n", "Y", "y$")

-- Yank to system clipboard
vim.keymap.set({ "n", "x" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "x" }, "<leader>Y", '"+y$')

vim.keymap.set("n", "<C-y>", 'mygg"+yG`y', { desc = "Yank entire file to system clipboard" })

vim.keymap.set("x", "<leader>x", '"+x', { desc = "Cut to system clipboard" })

vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set("x", "<leader>p", '_d"+P', { desc = "Paste from system clipboard" })
vim.keymap.set("c", "<C-v>", "<C-R>+", { desc = "Paste from system clipboard" })
vim.keymap.set(
	"i",
	"<C-v>",
	'<esc>:set paste<cr>a<c-r>=getreg("+")<cr><esc>:set nopaste<cr>mi`[=`]`ia',
	{ desc = "Paste from system clipboard" }
)

-- H/L go to start/end of line
vim.keymap.set({ "n", "o", "x" }, "L", "$")
vim.keymap.set({ "n", "x" }, "H", "0^")
vim.keymap.set("o", "H", "^")
vim.keymap.set({ "n", "x" }, "^", "0^")

-- Move selected text up/down, reformat, then reselect
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- Don't move cursor when joining below line
vim.keymap.set("n", "J", "mzJ`z")

-- Split (opposite of J for join)
vim.keymap.set({ "n", "x" }, "S", ":s/,/,\\r/g<CR>:nohlsearch<CR>V'<=", { silent = true })
--vim.keymap.set("n", "S", "yl/<C-r>0<CR>Ncgn<C-r>0<Del><CR><Esc>n:nohlsearch<CR>")

-- Reselect text after indenting/dedenting
vim.keymap.set("x", ">", ">gv")
vim.keymap.set("x", "<", "<gv")

vim.keymap.set("n", "<leader>/", "gcc", { desc = "Toggle comment line", remap = true })
vim.keymap.set("x", "<leader>/", "gc", { desc = "Toggle comment line", remap = true })
