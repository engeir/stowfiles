return {
    "ThePrimeagen/harpoon",
    opts = {
        menu = {
            width = math.floor(vim.api.nvim_win_get_width(0) * 0.5),
        },
    },
    keys = {
        {
            "<leader>hf",
            function()
                require("harpoon.ui").toggle_quick_menu()
            end,
            desc = "[H]arpoon [F]iles",
        },
        {
            "<leader>hm",
            function()
                require("harpoon.mark").add_file()
            end,
            desc = "[H]arpoon [M]ark",
        },
        {
            "<leader>hn",
            function()
                require("harpoon.ui").nav_next()
            end,
            desc = "[H]arpoon [N]ext",
        },
        {
            "<leader>hN",
            function()
                require("harpoon.ui").nav_prev()
            end,
            desc = "[H]arpoon [P]rev",
        },
    },
}
