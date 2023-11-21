return {
    "jay-babu/mason-nvim-dap.nvim",
    enabled = IS_KNOWN,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "mfussenegger/nvim-dap",
    },
    config = true,
}
