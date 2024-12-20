return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		-- handle installation of LSPs
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				auto_install = true,
				ensure_installed = {
					"gopls",
					"lua_ls",
					"ts_ls",
				},
			})
		end,
	},
	{
		-- handle installation of formatters/linters
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		config = function()
			require("mason-null-ls").setup({
				ensure_installed = {
					"eslint_d",
					"stylua",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "justinsgithub/wezterm-types", lazy = true },
			{
				-- Neovim completions
				"folke/lazydev.nvim",
				opts = {
					library = {
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
						{ path = "wezterm-types", mods = { "wezterm" } },
					},
				},
			},
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			--lspconfig.bashls.setup({
			--	filetypes = { "sh", "zsh" },
			--  capabilities = capabilities,
			--})
			lspconfig.gopls.setup({
				capabilities = capabilities,
			})
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
			})

			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
			-- vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })

			--vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol)
			--vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float)

			vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename symbol" })
			vim.keymap.set({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })

			vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
			vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, { desc = "Show function signature help" })

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
			vim.lsp.handlers["textDocument/signatureHelp"] =
				vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
		end,
	},
}
