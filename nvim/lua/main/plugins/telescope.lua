return {
    "nvim-telescope/telescope.nvim",
    version = '*',
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
            pickers = {},
            extensions = {
                fzf = {
                    fuzzy = true,                   -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true,    -- override the file sorter
                    case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                    -- the default case_mode is "smart_case"
                }
            },
        }

        require('telescope').load_extension('fzf')
    end
}
