return {
    "kyazdani42/nvim-tree.lua",
    dependencies = "kyazdani42/nvim-web-devicons", -- optional, for file icons
    version = "nightly",                           -- optional, updated every week. (see issue #1193)
    keys = {
        { "<leader>pf", "<cmd>NvimTreeFindFileToggle<CR>", desc = "NvimTree Find File" },
        { "<leader>pp", "<cmd>NvimTreeToggle<CR>",         desc = "NvimTree Toggle" },
    },
    opts = {
        hijack_cursor = true, -- keeps cursor at the first letter
        disable_netrw = true,
        view = {
            side = "right",
            width = 60,
        },
        actions = {
            open_file = {
                quit_on_open = true,
            },
        },
    },
}
