vim.pack.add({
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/seblyng/roslyn.nvim",
})

require("mason").setup({
	registries = {
		"github:Crashdummyy/mason-registry", -- needed for Roslyn
		"github:mason-org/mason-registry",
	},
})

-- Names must be Mason package names, not LSP names as used below for LSP config
local ensure_installed = {
	"bash-language-server",
	"bicep-lsp",
	"gopls",
	"json-lsp",
	"lua-language-server",
	"roslyn",
	-- "tailwindcss-language-server",
	"tree-sitter-cli",
	"typescript-language-server",
}

require("mason-registry").refresh(function()
	for _, name in ipairs(ensure_installed) do
		local pkg = require("mason-registry").get_package(name)
		if not pkg:is_installed() then
			pkg:install()
		end
	end
end)

vim.lsp.config["*"] = {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
}

-- LSP names: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
vim.lsp.config("bashls", {})
vim.lsp.config("bicep", {})
vim.lsp.config("gopls", {})
vim.lsp.config("jsonls", {})
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})
vim.lsp.config("roslyn", {})
vim.lsp.config("ts_ls", {})

vim.lsp.enable({
	"bashls",
	"bicep",
	"gopls",
	"jsonls",
	"lua_ls",
	"roslyn",
	"ts_ls",
})

local lsp_on_attach = function()
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
	-- vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })

	vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename symbol" })
	vim.keymap.set({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })

	vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
	vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, { desc = "Show function signature help" })

	vim.keymap.set(
		"n",
		"gs",
		"<C-w>v<cmd>lua vim.lsp.buf.definition()<CR>zz",
		{ desc = "Go to definition in vertical split" }
	)

	-- Disable built-in LSP ref keymaps to prevent gr from being slow; pcall swallows error
	pcall(vim.keymap.del, { "n", "x" }, "gra")
	pcall(vim.keymap.del, "n", "gri")
	pcall(vim.keymap.del, "n", "grn")
	pcall(vim.keymap.del, "n", "grr")
	pcall(vim.keymap.del, "n", "grt")
	pcall(vim.keymap.del, "n", "grx")
end

local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = false })
vim.api.nvim_create_autocmd("LspAttach", { group = augroup, callback = lsp_on_attach })

local diagnostic_signs = {
	Error = "",
	Warn = "",
	Hint = "",
	Info = "",
}

vim.diagnostic.config({
	virtual_text = { prefix = "●", spacing = 2 },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
			[vim.diagnostic.severity.WARN] = diagnostic_signs.Warn,
			[vim.diagnostic.severity.INFO] = diagnostic_signs.Info,
			[vim.diagnostic.severity.HINT] = diagnostic_signs.Hint,
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
		focusable = false,
		style = "minimal",
	},
})

vim.keymap.set("n", "<leader>K", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
