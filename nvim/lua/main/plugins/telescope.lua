return {
    "nvim-telescope/telescope.nvim",
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>fs', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {})

        require('telescope').setup {
            pickers = {
                find_files = {
                    theme = "dropdown",
                    hidden = true,
                    no_ignore = true,
                },
                live_grep = {
                    theme = "dropdown",
                    file_ignore_patterns = { "go.sum", ".git" },
                    additional_args = function(opts)
                        return { "--hidden", "--no-ignore-vcs" }
                    end
                },
                buffers = {
                    theme = "dropdown",
                },
            },
        }
    end
}
