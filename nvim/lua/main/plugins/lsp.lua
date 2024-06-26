return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/nvim-cmp",
        {
            "L3MON4D3/LuaSnip",
            build = "make install_jsregexp",
        },
        {
            "VonHeikemen/lsp-zero.nvim",
            branch = "v3.x",
        },
    },
    config = function()
        local lsp_zero = require('lsp-zero')

        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = { 'gopls', 'lua_ls' },
            handlers = {
                function(server_name)
                    require('lspconfig')[server_name].setup({})
                end,
            }
        })

        lsp_zero.on_attach(function(client, bufnr)
            lsp_zero.default_keymaps({ buffer = bufnr })

            if client.server_capabilities.documentHighlightProvider then
                vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
                vim.api.nvim_clear_autocmds { buffer = bufnr, group = "lsp_document_highlight" }
                vim.api.nvim_create_autocmd("CursorHold", {
                    callback = vim.lsp.buf.document_highlight,
                    buffer = bufnr,
                    group = "lsp_document_highlight",
                    desc = "Document Highlight",
                })
                vim.api.nvim_create_autocmd("CursorMoved", {
                    callback = vim.lsp.buf.clear_references,
                    buffer = bufnr,
                    group = "lsp_document_highlight",
                    desc = "Clear All the References",
                })
            end
        end)

        vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

        lsp_zero.setup()
    end
}
