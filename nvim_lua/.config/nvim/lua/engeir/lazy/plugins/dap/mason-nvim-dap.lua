return {
    "jay-babu/mason-nvim-dap.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "mfussenegger/nvim-dap",
    },
    config = true,
}
