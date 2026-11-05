return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "nvim-telescope/telescope-dap.nvim",
        "theHamsta/nvim-dap-virtual-text",
        "jay-babu/mason-nvim-dap.nvim",
        "leoluz/nvim-dap-go",
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        require("mason-nvim-dap").setup({
            automatic_setup = true,
            handlers = {},
            ensure_installed = { "delve" },
        })

        -- UI
        dapui.setup({
            icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
            controls = {
                icons = {
                    pause = "⏸",
                    play = "▶",
                    step_into = "⏎",
                    step_over = "⏭",
                    step_out = "⏮",
                    step_back = "b",
                    run_last = "▶▶",
                    terminate = "⏹",
                    disconnect = "⏏",
                },
            },
        })

        -- Keymaps
        vim.keymap.set("n", "<F5>", dap.continue)
        vim.keymap.set("n", "<F1>", dap.step_into)
        vim.keymap.set("n", "<F2>", dap.step_over)
        vim.keymap.set("n", "<F3>", dap.step_out)
        vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
        vim.keymap.set("n", "<leader>B", function()
            dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end)
        vim.keymap.set("n", "<F7>", dapui.toggle)

        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end

        -- dap-go (local dlv launch)
        require("dap-go").setup()

        -- Your env vars for envtest / project
        local kueue_env = {
            PROJECT_DIR = "/Users/mykyta_derhunov/Code/kueue/",
            KUBEBUILDER_ASSETS =
            "/Users/Mykyta_Derhunov/Library/Application Support/io.kubebuilder.envtest/k8s/1.35.0-darwin-arm64",
            KUEUE_BIN = "/Users/mykyta_derhunov/Code/kueue/bin/bin",
        }

        -- Single config: "ginkgo"
        dap.configurations.go = dap.configurations.go or {}
        table.insert(dap.configurations.go, {
            type = "go",
            name = "ginkgo",
            request = "launch",
            mode = "test",

            -- Debug one package: open a _test.go in that package and run <F5>
            program = "${fileDirname}",
            cwd = "${workspaceFolder}",

            env = kueue_env,

            -- test binary args; ginkgo flags work here too
            args = { "-test.v", "-ginkgo.v" },
        })
    end,
}
