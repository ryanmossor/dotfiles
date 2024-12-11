return {
    "folke/trouble.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    opts = {},
    cmd = "Trouble",
    config = function()
        require("trouble").setup({
            auto_jump = true,
        })
    end,
    keys = {
        {
            "<leader>tt",
            ":Trouble diagnostics toggle<CR>",
            desc = "Diagnostics (Trouble)",
        },
    },
}
