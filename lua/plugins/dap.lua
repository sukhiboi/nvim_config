-- ┌─────────────────────────────────────────┐
-- │  DEBUGGER (like IntelliJ's Debug tool)   │
-- └─────────────────────────────────────────┘
return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "williamboman/mason.nvim",
    },
    keys = {
        { "<F5>",       function() require("dap").continue() end,          desc = "Debug: Start/Continue" },
        { "<F9>",       function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle breakpoint" },
        { "<F10>",      function() require("dap").step_over() end,        desc = "Debug: Step over" },
        { "<F11>",      function() require("dap").step_into() end,        desc = "Debug: Step into" },
        { "<S-F11>",    function() require("dap").step_out() end,         desc = "Debug: Step out" },
        { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
        { "<leader>dc", function() require("dap").continue() end,          desc = "Continue" },
        { "<leader>dt", function() require("dap").terminate() end,         desc = "Stop debugging" },
    },
    config = function()
        local dap, dapui = require("dap"), require("dapui")
        dapui.setup()

        dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
        dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
        dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

        -- JS/TS/Jest debugging via Mason's js-debug-adapter (vscode-js-debug).
        -- Also what neotest-jest's `strategy = "dap"` (<leader>td) attaches through.
        local js_debug_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"
        dap.adapters["pwa-node"] = {
            type = "server",
            host = "localhost",
            port = "${port}",
            executable = {
                command = "node",
                args = { js_debug_path, "${port}" },
            },
        }

        for _, language in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact" }) do
            dap.configurations[language] = {
                {
                    type = "pwa-node",
                    request = "launch",
                    name = "Launch file",
                    program = "${file}",
                    cwd = "${workspaceFolder}",
                },
                {
                    type = "pwa-node",
                    request = "attach",
                    name = "Attach to process",
                    processId = require("dap.utils").pick_process,
                    cwd = "${workspaceFolder}",
                },
            }
        end
    end,
}
