vim.cmd("packadd nvim.undotree")
vim.opt.undofile = true
vim.keymap.set("n", "<leader>u", vim.cmd.Undotree, { desc = "Toggle Undotree" })
