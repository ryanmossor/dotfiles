return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local builtin = require("telescope.builtin")

        vim.keymap.set('n', '<leader>f', builtin.find_files, {})
        vim.keymap.set('n', '<leader>F', builtin.live_grep, {})

        local actions = require("telescope.actions")
        require("telescope").setup({
            defaults = {
                sorting_strategy = "ascending", -- show results starting from top
                layout_config = {
                    prompt_position = "top",    -- display prompt on top
                },
                mappings = {
                    i = {
                        -- close telescope on first escape press instead of entering insert mode
                        ["<esc>"] = actions.close,
                    },
                },
            },
        })
    end,
}
