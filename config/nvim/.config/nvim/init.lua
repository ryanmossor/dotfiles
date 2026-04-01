require("set")
require("keymaps")
require("autocmds")

vim.o.termguicolors = true
-- vim.cmd.colorscheme("catppuccin")
vim.diagnostic.config({
    virtual_text = true, -- inline diagnostics
})
