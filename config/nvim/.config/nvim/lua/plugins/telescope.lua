return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local builtin = require("telescope.builtin")

        vim.keymap.set('n', '<leader>f', function()
            builtin.find_files({
                hidden = true,
                no_ignore = false, -- respect .gitignore
                find_command = {
                    "rg",
                    "--files",
                    "--hidden",
                    "--glob", "!**/.git/**",
                    "--glob", "!**/node_modules/**"
                },
            })
        end, {})
        vim.keymap.set('n', '<leader>F', builtin.live_grep, {})

        local actions = require("telescope.actions")
        require("telescope").setup({
            defaults = {
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                    "--hidden",
                    "--ignore",
                    "--glob", "!**/.git/**",
                    "--glob", "!**/node_modules/**",
                },
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
