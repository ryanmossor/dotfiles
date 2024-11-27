return {
    "nvim-lualine/lualine.nvim",
    config = function()
        require("lualine").setup({
            options = {
                theme = "catppuccin",
            },
            sections = {
                lualine_x = { "encoding", "filetype" },
            },
        })
    end,
}
