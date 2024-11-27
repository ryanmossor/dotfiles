return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
                -- JS/TS
                null_ls.builtins.diagnostics.eslint_d,
                -- null_ls.builtins.formatting.eslint_d,

                -- Lua
                null_ls.builtins.formatting.stylua,
            },
        })

        vim.keymap.set('n', '<leader>gf', vim.lsp.buf.format, {})
    end,
}
