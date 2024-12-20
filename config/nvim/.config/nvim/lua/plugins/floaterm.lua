return {
    "voldikss/vim-floaterm",
    cmd = "FloatermNew",
    config = function()
        vim.api.nvim_create_autocmd({ "FileType" }, {
            pattern = "floaterm",
            command = "set norelativenumber nonumber",
        })

        vim.g.floaterm_title = ""
    end,
    keys = {
        {
            "<leader>G",
            function()
                vim.cmd.FloatermNew({
                    "--height=0.95",
                    "--width=0.9",
                    "--wintype=float",
                    "--name=lazygit",
                    "--autoclose=2",
                    "lazygit",
                })
            end,
            desc = "LazyGit",
        },
    },
}
