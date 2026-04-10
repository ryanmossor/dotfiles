vim.pack.add({
	"https://github.com/nvimtools/none-ls.nvim",
	"https://github.com/jay-babu/mason-null-ls.nvim",
	"https://github.com/nvimtools/none-ls-extras.nvim",
	-- "https://github.com/gbprod/none-ls-shellcheck.nvim",
})

require("mason-null-ls").setup({
	ensure_installed = {
		"eslint_d",
		-- "shellcheck",
		"stylua",
	},
})

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		-- Bash
		-- require("none-ls-shellcheck.code_actions"),
		-- require("none-ls-shellcheck.diagnostics"),

		-- JS/TS
		require("none-ls.code_actions.eslint_d"),
		require("none-ls.diagnostics.eslint_d"),
		require("none-ls.formatting.eslint_d"),

		-- Lua
		null_ls.builtins.formatting.stylua,
	},

	-- format on save
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ async = false })
				end,
			})
		end
	end,

	vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {}),
})
