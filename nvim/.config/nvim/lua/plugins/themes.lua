return {
    {
        "p00f/alabaster.nvim",
        lazy = false,
        name = "alabaster",
        config = function()
            vim.g.alabaster_dim_comments = true
        end,
    },
    {
        "catppuccin/nvim",
        lazy = false,
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                transparent_background = true,
                show_end_of_buffer = true,
                styles = {
                    comments = { "italic" },
                    conditionals = {},
                    miscs = {},
                },
                integrations = {
                    treesitter = true,
                },
            })
        end,
    },
}
