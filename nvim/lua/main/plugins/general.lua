return {
    -- May use later:
    -- {
    --     'mrcjkb/rustaceanvim',
    --     lazy = false, -- This plugin is already lazy
    -- },
    {
        "karb94/neoscroll.nvim",
        config = function()
            require('neoscroll').setup({})
        end
    },
    {
        "folke/trouble.nvim",
        opts = {},
        cmd = "Trouble",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
        },
    },
    {
        'numToStr/Comment.nvim',
        opts = {},
        lazy = false,
    },
    "github/copilot.vim",
    {
        "tpope/vim-fugitive",
        config = function()
            vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end,
    },
    "olexsmir/gopher.nvim",

    -- Points for style:
    -- check rainbow-delimeters.nvim
    "nvim-tree/nvim-web-devicons",
    { "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
}
