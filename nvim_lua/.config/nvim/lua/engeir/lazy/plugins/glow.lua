return {
    "ellisonleao/glow.nvim",
    enabled = IS_KNOWN,
    branch = "main",
    cmd = "Glow",
    config = true,
    init = function()
        vim.g.glow_border = "rounded"
    end,
}
