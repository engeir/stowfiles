return {
    "jackMort/ChatGPT.nvim",
    enabled = IS_KNOWN,
    event = "VeryLazy",
    opts = {
        api_key_cmd = "pass ChatGPT/nvim-api-key",
    },
    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
}
