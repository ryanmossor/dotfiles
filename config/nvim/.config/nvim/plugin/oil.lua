vim.pack.add({ "https://github.com/stevearc/oil.nvim" })

local detail = false
require("oil").setup({
	default_file_explorer = true,
	delete_to_trash = true,
	skip_confirm_for_simple_edits = true,
	view_options = {
		show_hidden = true,
		is_always_hidden = function(name, _)
			return name == ".." or name == ".git"
		end,
	},
	win_options = {
		wrap = true,
	},
	columns = {
		"icon",
		-- "permissions",
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

		["gp"] = {
			desc = "Toggle file permissions view",
			callback = function()
				detail = not detail
				if detail then
					require("oil").set_columns({ "permissions", "icon" })
				else
					require("oil").set_columns({ "icon" })
				end
			end,
		},
	},
})

vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "File explorer" })

-- Disable netrw as default file explorer
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
