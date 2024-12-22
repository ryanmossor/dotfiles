return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()

        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Add buffer to Harpoon jump list" })
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Edit Harpoon jump list" })

        vim.keymap.set("n", "<C-j>", function() harpoon:list():select(1) end, { desc = "Jump to Harpoon buffer 1" })
        vim.keymap.set("n", "<C-k>", function() harpoon:list():select(2) end, { desc = "Jump to Harpoon buffer 2" })
        vim.keymap.set("n", "<C-l>", function() harpoon:list():select(3) end, { desc = "Jump to Harpoon buffer 3" })
        vim.keymap.set("n", "<C-;>", function() harpoon:list():select(4) end, { desc = "Jump to Harpoon buffer 4" })

        -- Toggle previous & next buffers stored within Harpoon list
        -- vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
        -- vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
    end,
}
