return {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
        require("catppuccin").setup({
            flavour = "macchiato", -- latte, frappe, macchiato, mocha
            transparent_background = true,
            show_end_of_buffer = true,
            integrations = {
                cmp = true,
                indent_blankline = {
                    enabled = true,
                    colored_indent_levels = true,
                },
                lsp_trouble = true,
                mason = true,
                telescope = true,
                treesitter = true,
                ts_rainbow2 = true,
            },
        })

        vim.cmd.colorscheme "catppuccin"
    end
}
