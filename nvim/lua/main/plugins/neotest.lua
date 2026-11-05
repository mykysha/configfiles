return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        {
            "nvim-treesitter/nvim-treesitter",
            branch = "main", -- REQUIRED: not master. neotest-golang v2+ breaks otherwise.
            build = function() vim.cmd(":TSUpdate go") end,
        },
        {
            "fredrikaverpil/neotest-golang",
            version = "*", -- track releases, not tip-of-main
            build = function()
                -- Optional: gotestsum is the recommended runner (see note below)
                vim.system({ "go", "install", "gotest.tools/gotestsum@latest" }):wait()
            end,
        },
        "leoluz/nvim-dap-go",
    },
    config = function()
        local neotest = require("neotest")
        neotest.setup({
            adapters = {
                require("neotest-golang")({
                    runner = "gotestsum", -- omit to use plain `go test`
                }),
            },
        })
        local function run_file()
            neotest.run.run(vim.fn.expand("%"))
        end
        vim.keymap.set("n", "<leader>to", neotest.summary.toggle)
        vim.keymap.set("n", "<leader>tr", neotest.run.run)
        vim.keymap.set("n", "<leader>td", require("dap-go").debug_test)
        vim.keymap.set("n", "<leader>tf", run_file)
        vim.keymap.set("n", "<leader>ts", neotest.run.stop)
    end,
}
