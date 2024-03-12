local neotest = require("neotest")

neotest.setup({
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
    neotest.run.run(vim.fn.expand("%"))
end

local function debug()
    neotest.run.run({ strategy = "dap" })
end

vim.keymap.set('n', '<leader>to', neotest.summary.toggle)
vim.keymap.set('n', '<leader>tr', neotest.run.run)
vim.keymap.set('n', '<leader>td', require('dap-go').debug_test)
vim.keymap.set('n', '<leader>tf', run_all)
vim.keymap.set('n', '<leader>ts', neotest.run.stop)
