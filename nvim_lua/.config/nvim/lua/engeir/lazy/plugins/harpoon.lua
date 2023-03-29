return {
    "ThePrimeagen/harpoon",
    opts = {
        menu = {
            width = math.floor(vim.api.nvim_win_get_width(0) * 0.5),
        },
    },
    keys = {
        { "<leader>hf", '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>' },
        { "<leader>hm", '<cmd>lua require("harpoon.mark").add_file()<CR>' },
        { "<leader>hn", '<cmd>lua require("harpoon.ui").nav_next()<CR>' },
        { "<leader>hN", '<cmd>lua require("harpoon.ui").nav_prev()<CR>' },
    },
}
