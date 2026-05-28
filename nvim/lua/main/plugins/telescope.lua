return {
    "nvim-telescope/telescope.nvim",
    tag = '*',
    dependencies = { 'nvim-lua/plenary.nvim', { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' } },
    config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>fs', builtin.live_grep, {})
        vim.keymap.set("n", "<leader>gu", builtin.lsp_references, {})

        require('telescope').setup {
            defaults = {
                layout_strategy = 'vertical',
                layout_config = {
                    vertical = {
                        width = 0.99,
                        height = 0.99,
                        preview_height = 0.5,
                        preview_cutoff = 1,
                    },
                },
                file_ignore_patterns = { "go.sum", ".git", "bin/", "node_modules/", "vendor/", "CHANGELOG/" },
            },
            pickers = {
                find_files = {
                    hidden = true,
                    no_ignore = true,
                },
                live_grep = {
                    additional_args = function(opts)
                        return { "--hidden", "--no-ignore-vcs" }
                    end
                },
            },
        }
    end
}
