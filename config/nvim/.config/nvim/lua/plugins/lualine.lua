return {
    "nvim-lualine/lualine.nvim",
    config = function()
        require("lualine").setup({
            options = {
                section_separators = "",
                component_separators = "|",
            },
            sections = {
                lualine_b = {
                    { "branch", icon = "󰘬" },
                    "diff",
                    "diagnostics",
                },
                lualine_c = {
                    -- 0: Just the filename
                    -- 1: Relative path
                    -- 2: Absolute path
                    -- 3: Absolute path, with tilde as the home directory
                    -- 4: Filename and parent dir, with tilde as the home directory
                    { "filename", path = 4 },
                },
                lualine_x = {
                    "selectioncount",
                    "searchcount",
                    -- "encoding",
                    "filetype",
                },
                lualine_y = {
                    -- "progress"
                },
                lualine_z = {
                    "location",
                },
            },
        })
    end,
}
