vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Required:
    use 'wbthomason/packer.nvim'

    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {
                'williamboman/mason.nvim',
                run = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
        },
    }

    -- Very good to have:
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use({
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup {
                icons = false,
            }
        end
    })

    use 'nvim-treesitter/nvim-treesitter-context'

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    use "github/copilot.vim"
    use "tpope/vim-fugitive"
    use {
        'j-hui/fidget.nvim', opts = {},
    }
    use 'lewis6991/gitsigns.nvim'
    use "olexsmir/gopher.nvim"
    use {
        "nvim-neotest/neotest",
        requires = {
            "nvim-neotest/neotest-go",
            "rouge8/neotest-rust",

            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim"
        }
    }

    -- Points for style:

    use { "catppuccin/nvim", as = "catppuccin" }

    use "lukas-reineke/indent-blankline.nvim"

    use 'HiPhish/nvim-ts-rainbow2'

    use 'nvim-tree/nvim-web-devicons'
    use 'nvim-lualine/lualine.nvim'
end)
