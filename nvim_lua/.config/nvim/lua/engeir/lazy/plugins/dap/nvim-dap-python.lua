return {
    "mfussenegger/nvim-dap-python",
    enabled = IS_KNOWN,
    ft = "python",
    dependencies = {
        "mfussenegger/nvim-dap",
        "rcarriga/nvim-dap-ui",
    },
    keys = {
        { "<leader>dpr", function ()
            require("dap-python").test_method()
        end}
    },
    config = function ()
        require("dap-python").setup("/home/een023/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
    end,
}
