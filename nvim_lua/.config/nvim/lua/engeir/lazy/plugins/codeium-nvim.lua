return {
    "Exafunction/codeium.nvim",
    enabled = IS_KNOWN and IS_LINUX,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
    },
    config = true,
}
