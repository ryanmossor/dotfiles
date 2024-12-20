return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,
			view_options = {
				show_hidden = true,
				is_always_hidden = function(name, _)
					return name == ".git"
				end,
			},
			win_options = {
				wrap = true,
			},
			columns = {
				"icon",
				"permissions",
				-- "size",
				-- "mtime",
			},
			float = {
				padding = 5,
			},
			keymaps = {
				["<C-h>"] = false,
				["<C-j>"] = false,
				["<C-k>"] = false,
				["<C-l>"] = false,
				["?"] = { "actions.show_help", mode = "n" },
			},
		})

		vim.keymap.set("n", "<leader>E", "<cmd>Oil<CR>", { desc = "File explorer" })
		vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "File explorer" })

        -- Disable netrw as default file explorer
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
	end,
}
