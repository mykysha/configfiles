return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    opts = {
        indent = { enable = true },
        highlight = { enable = true },
        folds = { enable = true },
        ensure_installed = { "go", "rust", "dockerfile", "gitignore",
            "gomod", "gosum", "gowork", "make", "sql", "toml", "yaml",
            "c", "lua", "vim", "vimdoc", "query" },
    },
    config = function()
        vim.api.nvim_create_autocmd("FileType", {
            -- This will make TS install parser for each new filetype you open.
            -- If you want only specific filetypes, change `{ "*" }` to a list
            -- of preferred filetypes (not languages, unlike `ensure_installed`).
            pattern = { "*" },
            callback = function(args)
                local ft = vim.bo[args.buf].filetype
                local lang = vim.treesitter.language.get_lang(ft)

                if not vim.treesitter.language.add(lang) then
                    local available = vim.g.ts_available
                        or require("nvim-treesitter").get_available()
                    if not vim.g.ts_available then
                        vim.g.ts_available = available
                    end
                    if vim.tbl_contains(available, lang) then
                        require("nvim-treesitter").install(lang)
                    end
                end

                if vim.treesitter.language.add(lang) then
                    vim.treesitter.start(args.buf, lang)
                    -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    -- vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
                    -- vim.wo[0][0].foldmethod = "expr"
                end
            end,
        })
    end,
}
