return {
    "nvim-telescope/telescope.nvim",
    "axkirillov/easypick.nvim",
    "nvim-telescope/telescope-bibtex.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    {
        "AckslD/nvim-neoclip.lua",
        config = function()
            require("neoclip").setup({ default_register = { '"', "+", "*" } })
            require("telescope").load_extension("neoclip")
        end,
    },
    "nvim-telescope/telescope-symbols.nvim",
    {
        "nvim-telescope/telescope-media-files.nvim",
        dependencies = { "nvim-lua/popup.nvim" },
        cond = IS_KNOWN and IS_LINUX,
    },

}
