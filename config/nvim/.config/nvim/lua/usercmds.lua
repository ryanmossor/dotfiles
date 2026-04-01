vim.api.nvim_create_user_command("PackList", function()
	vim.pack.update(nil, { offline = true })
end, { desc = "Update vim.pack plugins" })

vim.api.nvim_create_user_command("PackDelete", function(opts)
	vim.pack.del(opts.fargs)
end, { desc = "Delete vim.pack plugins (Usage: PackDelete plugin1 plugin2)", nargs = "+" })

vim.api.nvim_create_user_command("PackUpdate", "lua vim.pack.update()", { desc = "Update vim.pack plugins" })
