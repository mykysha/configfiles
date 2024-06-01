return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "linrongbin16/lsp-progress.nvim",
    },
    config = function()
        require("lsp-progress").setup({
            format = function(client_messages)
                if #client_messages > 0 then
                    return table.concat(client_messages, " ")
                end
                return ""
            end,
        })

        require('lualine').setup {
            options = {
                icons_enabled = true,
                theme = 'catppuccin',
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = false,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                }
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = {
                    'branch',
                    'diff',
                    {
                        'diagnostics',
                        symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' },
                    }
                },
                lualine_c = {
                    'filename',
                    function()
                        return require('lsp-progress').progress()
                    end,
                },
                lualine_x = { 'fileformat', 'filetype' },
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {}
        }

        vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
        vim.api.nvim_create_autocmd("User", {
            group = "lualine_augroup",
            pattern = "LspProgressStatusUpdated",
            callback = require("lualine").refresh,
        })
    end
}
