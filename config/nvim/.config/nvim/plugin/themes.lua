vim.pack.add({
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
})

require("catppuccin").setup({
	flavour = "mocha",
	transparent_background = true,

	styles = {
		comments = { "italic" },
		conditionals = {},
		miscs = {},
	},

	highlight_overrides = {
		mocha = function(mocha)
			return {
				LineNr = { fg = mocha.subtext0 },
				LspInlayHint = { fg = mocha.overlay1, style = { "italic" } },
			}
		end,
	},

	float = {
		transparent = true,
		solid = false,
	},
})

vim.cmd.colorscheme("catppuccin")
