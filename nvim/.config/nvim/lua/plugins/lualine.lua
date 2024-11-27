return {
    "nvim-lualine/lualine.nvim",
    config = function()
        require("lualine").setup({
            options = {
              section_separators = "",
              component_separators = "|",
            },
            sections = {
                lualine_x = { "encoding", "filetype" },
            },
        })
    end,
}
