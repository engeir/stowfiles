return {
    "folke/flash.nvim",
    -- Probably a good plugin, but I don't know how to use it. It breaks ct<character>
    -- and the dot repeat of the motion, for example.
    enabled = IS_KNOWN,
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    keys = {
        {
            "s",
            mode = { "n", "x", "o" },
            function()
                -- default options: exact mode, multi window, all directions, with a backdrop
                require("flash").jump()
            end,
        },
        {
            "S",
            mode = { "o", "x" },
            function()
                require("flash").treesitter()
            end,
        },
    },
}
