return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    ---@module "fzf-lua"
    ---@type fzf-lua.Config|{}
    ---@diagnostic enable: missing-fields
    config = function()
        require("fzf-lua").setup({
            keymap = {
                fzf = {
                    ["ctrl-d"] = "preview-page-down",
                    ["ctrl-u"] = "preview-page-up",
                    ["ctrl-q"] = "select-all+accept",
                },
            },

            files = {
                previewer = false,
                cwd_prompt = false,
            },

            grep = {
                rg_opts =
                "--color=never --no-heading --with-filename --line-number --column --smart-case --hidden --ignore --trim --glob !**/.git/** --glob !**/node_modules/**",
            },

            winopts = {
                width = 0.9,
                height = 0.95,
                preview = {
                    layout = "vertical",
                    vertical = "down:65%",
                    horizontal = "right:50%",
                },
            },
        })

        vim.keymap.set("n", "<leader>f", function()
            require("fzf-lua").files()
        end, { desc = "FZF files" })

        vim.keymap.set("n", "<leader>F", function()
            require("fzf-lua").live_grep()
        end, { desc = "FZF live grep" })

        vim.keymap.set("n", "gr", function()
            require("fzf-lua").lsp_references()
        end, { desc = "FZF find references" })

        vim.keymap.set("n", "<leader>h", function()
            require("fzf-lua").help_tags()
        end, { desc = "FZF help tags" })

        vim.keymap.set("n", "<leader>k", function()
            require("fzf-lua").keymaps()
        end, { desc = "FZF keymaps" })

        vim.keymap.set("n", "<leader>wd", function()
            require("fzf-lua").diagnostics_workspace()
        end, { desc = "FZF diagnostics workspace" })

        vim.keymap.set("n", "<leader>qf", function()
            require("fzf-lua").lgrep_quickfix()
        end, { desc = "FZF quickfix" })

        vim.keymap.set("n", "<leader>pws", function()
            require("fzf-lua").grep_cword()
        end, { desc = "FZF search word under cursor" })

        vim.keymap.set("n", "<leader>pWs", function()
            require("fzf-lua").grep_cWORD()
        end, { desc = "FZF search WORD under cursor" })

        vim.keymap.set("x", "<leader>pvs", function()
            require("fzf-lua").grep_visual()
        end, { desc = "FZF search visual selection" })
    end,
}
