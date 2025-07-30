-- Line numbers
vim.opt.number = true

-- Display insert/visual/command/etc mode
vim.opt.showmode = false

-- Relative line numbers
vim.opt.relativenumber = true

-- Minimum # of line numbers to display above/below cursor
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 20

-- Ignore case when searching
vim.opt.ignorecase = true

-- Overrides ignorecase if search pattern includes uppercase letters
vim.opt.smartcase = true

-- Highlight search matches
vim.opt.hlsearch = true

-- Incrementally highlight matches for search pattern while typing
vim.opt.incsearch = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Text wrapping
vim.opt.wrap = false

-- Always display signs gutter (git changes, diagnostics, etc.)
vim.opt.signcolumn = "yes"

-- Allow special chars in filenames
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "120"

-- Smart auto-indent on newline
vim.opt.smartindent = true

-- When on, a <Tab> in front of a line inserts blanks according to 'shiftwidth'
vim.opt.smarttab = true

-- Command-line completion operates in an enhanced mode
vim.opt.wildmenu = true

-- Completion mode that is used for the character specified with 'wildchar'
-- vim.opt.wildmode=longest:full,full

-- split window preferences
vim.opt.splitright = true -- split vertical window to the right
vim.opt.splitbelow = true -- split horizontal window to the bottom

vim.opt.swapfile = false
