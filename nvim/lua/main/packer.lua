vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
    -- Required:
    use "wbthomason/packer.nvim"
    use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
    use {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        requires = {
            -- LSP Support
            { "neovim/nvim-lspconfig" }, -- Required
            {
                "williamboman/mason.nvim",
                run = function()
                    pcall(vim.cmd, "MasonUpdate")
                end,
            },
            { "williamboman/mason-lspconfig.nvim" },
            -- Autocompletion
            { "hrsh7th/nvim-cmp" },     -- Required
            { "hrsh7th/cmp-nvim-lsp" }, -- Required
            {
                "L3MON4D3/LuaSnip",
                run = "make install_jsregexp",
            }, -- Required
        },
    }

    -- Very good to have:
    use { "nvim-telescope/telescope.nvim", branch = "0.1.x" }
    use "nvim-lua/plenary.nvim"
    use "mfussenegger/nvim-dap"
    use {
        "rcarriga/nvim-dap-ui",
        requires = {
            "nvim-neotest/nvim-nio",
        }
    }
    use "theHamsta/nvim-dap-virtual-text"
    use "jay-babu/mason-nvim-dap.nvim"
    use "leoluz/nvim-dap-go"
    use "simrat39/rust-tools.nvim"
    use "nvim-telescope/telescope-dap.nvim"
    use {
        "folke/trouble.nvim",
        tag = "v2.10.0"
    }
    use "nvim-treesitter/nvim-treesitter-context"
    use "numToStr/Comment.nvim"
    use "github/copilot.vim"
    use "tpope/vim-fugitive"
    use "linrongbin16/lsp-progress.nvim"
    use "lewis6991/gitsigns.nvim"
    use "olexsmir/gopher.nvim"
    use {
        "nvim-neotest/neotest",
        requires = {
            "nvim-neotest/neotest-go",
            "rouge8/neotest-rust",
            -- dependencies
            "antoinemadec/FixCursorHold.nvim"
        }
    }

    -- Points for style:
    use { "catppuccin/nvim", as = "catppuccin" }
    use "lukas-reineke/indent-blankline.nvim"
    -- check rainbow-delimeters.nvim
    use "nvim-tree/nvim-web-devicons"
    use "nvim-lualine/lualine.nvim"
    use { "ellisonleao/glow.nvim", config = function() require("glow").setup() end }
end)
