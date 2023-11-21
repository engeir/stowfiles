return {
    "mfussenegger/nvim-dap",
    enabled = IS_KNOWN,
    cmd = { "DapToggleBreakpoint" },
    keys = {
        { "<leader>db", "<cmd>DapToggleBreakpoint<CR>", desc = "[D]ap Toggle [B]reakpoint" }
    }
}
