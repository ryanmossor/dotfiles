vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })
require("gitsigns").setup()

vim.keymap.set("n", "<leader>gd", ":Gitsigns preview_hunk<CR>", { desc = "Preview git diff", silent = true })
