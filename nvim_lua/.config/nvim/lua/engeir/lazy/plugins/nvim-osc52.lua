return {
    "ojroques/nvim-osc52",
    opts = {
        tmux_passthrough = true,
    },
    keys = {
        {
            "<leader>y",
            function()
                require("osc52").copy_operator()
            end,
            expr = true,
            desc = "Copy Operator",
        },
        { "<leader>yy", "<leader>y_", remap = true, desc = "Copy Current Line" },
        {
            "<leader>y",
            function()
                require("osc52").copy_visual()
            end,
            desc = "Copy Visual",
            mode = "v",
        },
    },
}
