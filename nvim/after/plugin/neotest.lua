require("neotest").setup({
    adapters = {
        require("neotest-go")({
            experimental = {
                test_table = true,
            },
        }),
        require("neotest-rust")
    },
})

local function run_all()
    require("neotest").run.run(vim.fn.expand("%"))
end

vim.keymap.set('n', '<leader>to', require("neotest").summary.toggle)
vim.keymap.set('n', '<leader>tr', require('neotest').run.run)
vim.keymap.set('n', '<leader>tf', run_all)
vim.keymap.set('n', '<leader>ts', require('neotest').run.stop)
