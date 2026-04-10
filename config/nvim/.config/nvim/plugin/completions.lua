vim.pack.add({
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
})

require("blink.cmp").setup({
	keymap = {
		preset = "none",
		-- ["<C-Space>"] = { "show", "hide" },
		["<CR>"] = { "accept", "fallback" },
		["<Tab>"] = { "accept", "fallback" },
		["<C-j>"] = { "select_next", "fallback" },
		["<C-k>"] = { "select_prev", "fallback" },
		["<C-n>"] = { "select_next", "fallback" },
		["<C-p>"] = { "select_prev", "fallback" },
		["<Down>"] = { "select_next", "fallback" },
		["<Up>"] = { "select_prev", "fallback" },
		-- ["<Tab>"] = { "snippet_forward", "fallback" },
		-- ["<S-Tab>"] = { "snippet_backward", "fallback" },
	},

	appearance = {
		nerd_font_variant = "mono",
	},

	completion = {
		menu = {
			-- auto_show = true,
			draw = {
				columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "kind" } },
			},
		},
	},

	sources = {
		default = {
			"lsp",
			"path",
			-- "buffer",
			-- "snippets",
		},
	},

	-- snippets = {
	-- 	expand = function(snippet)
	-- 		require("luasnip").lsp_expand(snippet)
	-- 	end,
	-- },

	-- signature = {
	-- 	enabled = true,
	-- },

	fuzzy = {
		implementation = "prefer_rust",
		prebuilt_binaries = { download = true },
	},
})
