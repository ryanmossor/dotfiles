return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		local builtin = require("telescope.builtin")

		local actions = require("telescope.actions")
		require("telescope").setup({
			defaults = {
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--hidden",
					"--ignore",
					"--trim",
					"--glob", "!**/.git/**",
					"--glob", "!**/node_modules/**",
				},
				sorting_strategy = "ascending", -- show results starting from top
				layout_config = {
					prompt_position = "top", -- display prompt on top
				},
				-- mappings = {
				-- 	i = {
				-- 		-- close telescope on first escape press instead of entering insert mode
				-- 		["<esc>"] = actions.close,
				-- 	},
				-- },
				initial_mode = "insert",
                path_display = {
                    "truncate",
                },
			},
			pickers = {
                find_files = {
                    theme = "dropdown",
                    previewer = false,
                },
				grep_string = {
					theme = "ivy",
					initial_mode = "normal",
				},
				lsp_references = {
					theme = "ivy",
					initial_mode = "normal",
				},
			},
			extensions = {
				fzf = {},
			},
		})

		require("telescope").load_extension("fzf")

		vim.keymap.set("n", "<leader>f", function()
			builtin.find_files({
				hidden = true,
				no_ignore = false, -- respect .gitignore
				find_command = {
					"rg",
					"--files",
					"--hidden",
					"--trim",
					"--smart-case",
					"--glob", "!**/.git/**",
					"--glob", "!**/node_modules/**",
				},
			})
		end, { desc = "Telescope find files" })

		vim.keymap.set("n", "<leader>F", builtin.live_grep, { desc = "Telescope search in files" })

		vim.keymap.set("n", "<leader>h", builtin.help_tags, { desc = "Telescope help tags" })
		vim.keymap.set("n", "<leader>k", builtin.keymaps, { desc = "Telescope keymaps" })

		vim.keymap.set("n", "gr", function()
			builtin.lsp_references({ show_line = false })
		end, { desc = "Telescope go to references" })

		vim.keymap.set("n", "<leader>pws", builtin.grep_string, { desc = "Telescope project word search" })
		vim.keymap.set("n", "<leader>pWs", function()
			builtin.grep_string({
				search = vim.fn.expand("<cWORD>"),
			})
		end, { desc = "Telescope project WORD search" })
	end,
}
