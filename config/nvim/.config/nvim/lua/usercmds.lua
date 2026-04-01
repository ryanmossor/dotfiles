vim.api.nvim_create_user_command("PackList", function()
	vim.pack.update(nil, { offline = true })
end, { desc = "Update vim.pack plugins" })

vim.api.nvim_create_user_command("PackDelete", function(opts)
	vim.pack.del(opts.fargs)
end, { desc = "Delete vim.pack plugins (Usage: PackDelete plugin1 plugin2)", nargs = "+" })

vim.api.nvim_create_user_command("PackUpdate", "lua vim.pack.update()", { desc = "Update vim.pack plugins" })

local function pack_clean()
	local active_plugins = {}
	local unused_plugins = {}

	for _, plugin in ipairs(vim.pack.get()) do
		active_plugins[plugin.spec.name] = plugin.active
	end

	for _, plugin in ipairs(vim.pack.get()) do
		if not active_plugins[plugin.spec.name] then
			table.insert(unused_plugins, plugin.spec.name)
		end
	end

	if #unused_plugins == 0 then
		print("No unused plugins.")
		return
	end

	local choice = vim.fn.confirm("Remove unused plugins?", "&Yes\n&No", 2)
	if choice == 1 then
		vim.pack.del(unused_plugins)
	end
end

vim.api.nvim_create_user_command("PackClean", pack_clean, { desc = "Clean unused vim.pack plugins" })
