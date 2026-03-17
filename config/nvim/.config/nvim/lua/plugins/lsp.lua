return {
    {
        "mason-org/mason.nvim",
        config = function()
            require("mason").setup({
                registries = {
                    "github:Crashdummyy/mason-registry", -- this contains the register for Roslyn
                    "github:mason-org/mason-registry",
                },
            })
        end,
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "gopls",
                "jsonls",
                "lua_ls",
                "ts_ls",
                -- "roslyn",
            },
            automatic_enable = true, -- disables need to setup handlers manually
        },
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
    },
    {
        -- handle installation of formatters/linters
        "jay-babu/mason-null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "mason-org/mason.nvim",
            "nvimtools/none-ls.nvim",
        },
        config = function()
            require("mason-null-ls").setup({
                ensure_installed = {
                    "eslint_d",
                    "stylua",
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "justinsgithub/wezterm-types", lazy = true },
            {
                -- Neovim completions
                "folke/lazydev.nvim",
                opts = {
                    library = {
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                        { path = "wezterm-types",      mods = { "wezterm" } },
                    },
                },
            },
        },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            vim.lsp.config("*", { capabilities = capabilities })

            vim.lsp.config("bashls", {})
            vim.lsp.config("gopls", {})
            vim.lsp.config("jsonls", {})
            vim.lsp.config("lua_ls", {})
            vim.lsp.config("ts_ls", {})

            vim.lsp.enable({
                "bashls",
                "gopls",
                "jsonls",
                "lua_ls",
                "ts_ls",
            })

            vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
            -- vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })

            --vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol)
            --vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float)

            vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename symbol" })
            vim.keymap.set({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })

            vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
            vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, { desc = "Show function signature help" })
        end,
    },
    {
        "seblyng/roslyn.nvim",
        enabled = true,
        ft = "cs",
        config = function()
            vim.lsp.config("roslyn", {
                -- on_attach = function()
                --     print("This will run when the server attaches!")
                -- end,
                settings = {
                    -- Check settings in https://github.com/seblyng/roslyn.nvim
                },
            })
            local roslyn = require("roslyn")
            roslyn.setup()
        end,
    },
}
