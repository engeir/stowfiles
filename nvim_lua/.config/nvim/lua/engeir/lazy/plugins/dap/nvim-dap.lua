local dap_enabled = false
return {
  {
    "mfussenegger/nvim-dap",
    enabled = dap_enabled,
    cmd = { "DapToggleBreakpoint" },
    keys = {
      {
        "<leader>db",
        "<cmd>DapToggleBreakpoint<CR>",
        desc = "[D]ap Toggle [B]reakpoint",
      },
    },
  },
  {
    "mfussenegger/nvim-dap-python",
    enabled = dap_enabled,
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    keys = {
      {
        "<leader>dpr",
        function() require("dap-python").test_method() end,
      },
    },
    config = function()
      require("dap-python").setup(
        "/home/een023/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      )
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    enabled = dap_enabled,
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    enabled = dap_enabled,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    config = true,
  },
}
