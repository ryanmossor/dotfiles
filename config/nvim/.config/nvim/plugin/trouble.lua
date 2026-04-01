vim.pack.add({ "https://github.com/folke/trouble.nvim" })

require("trouble").setup({
	auto_jump = true,
})

vim.keymap.set("n", "<leader>tt", ":Trouble diagnostics toggle<CR>", {
	desc = "Diagnostics (Trouble)",
})
