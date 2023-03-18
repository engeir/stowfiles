return {
    -- General text manipulation and fonts ========================================== --
    { "phaazon/mind.nvim",  cond = IS_KNOWN },
    -- "gaoDean/autolist.nvim",
    {
        "asiryk/auto-hlsearch.nvim",
        version = "1.0.0",
        config = function()
            require("auto-hlsearch").setup()
        end,
    },
}
