vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim",
	{ src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
})

local harpoon = require("harpoon")
harpoon.setup()

vim.keymap.set("n", "<leader>a", function()
	harpoon:list():add()
end, { desc = "Add buffer to Harpoon jump list" })

vim.keymap.set("n", "<C-e>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Edit Harpoon jump list" })

vim.keymap.set("n", "<C-1>", function()
	harpoon:list():select(1)
end, { desc = "Jump to Harpoon buffer 1" })

vim.keymap.set("n", "<C-2>", function()
	harpoon:list():select(2)
end, { desc = "Jump to Harpoon buffer 2" })

vim.keymap.set("n", "<C-3>", function()
	harpoon:list():select(3)
end, { desc = "Jump to Harpoon buffer 3" })

vim.keymap.set("n", "<C-4>", function()
	harpoon:list():select(4)
end, { desc = "Jump to Harpoon buffer 4" })

-- Toggle previous & next buffers stored within Harpoon list
-- vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
-- vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
