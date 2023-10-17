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
                return { "--hidden" }
            end
        },
        buffers = {
            theme = "dropdown",
        },
    },
}
