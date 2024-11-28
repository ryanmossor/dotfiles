return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvimtools/none-ls-extras.nvim",
        "gbprod/none-ls-shellcheck.nvim",
    },
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
                -- Bash
                require("none-ls-shellcheck.code_actions"),
                require("none-ls-shellcheck.diagnostics"),

                -- JS/TS
                require("none-ls.code_actions.eslint_d"),
                require("none-ls.diagnostics.eslint_d"),
                require("none-ls.formatting.eslint_d"),

                -- Lua
                null_ls.builtins.formatting.stylua,
            },
        })

        vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
    end,
}