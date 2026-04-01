vim.pack.add({
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
})

require("catppuccin").setup({
	flavour = "mocha",
	transparent_background = true,
	show_end_of_buffer = true,
	styles = {
		comments = { "italic" },
		conditionals = {},
		miscs = {},
	},
	integrations = {
		blink_cmp = {
			style = "bordered",
		},
		fzf = true,
		gitsigns = true,
		harpoon = true,
		mason = true,
		treesitter = true,
		treesitter_context = true,
	},
	highlight_overrides = {
		mocha = function(mocha)
			return {
				LineNr = { fg = mocha.subtext0 },
			}
		end,
	},
	float = {
		transparent = true,
		solid = false,
	},
})

vim.cmd.colorscheme("catppuccin")
