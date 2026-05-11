vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })

require("gitsigns").setup({
	on_attach = function()
		local gitsigns = require("gitsigns")

		vim.keymap.set("n", "<leader>gd", gitsigns.preview_hunk_inline, { desc = "Preview git diff", silent = true })
		vim.keymap.set("n", "]g", gitsigns.next_hunk, { desc = "Next git hunk", silent = true })
		vim.keymap.set("n", "[g", gitsigns.prev_hunk, { desc = "Previous git hunk", silent = true })
	end,
})
