return {
    "tpope/vim-fugitive",
    {
        "lewis6991/gitsigns.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "sindrets/diffview.nvim",
        config = function()
            require("diffview")
        end,
        keys = {
            { "dc", ":DiffviewClose<cr>", { silent = true, noremap = true } },
            { "do", ":DiffviewOpen<cr>",  { silent = true, noremap = true } },
        },
    },
    { "TimUntersberger/neogit", cond = IS_KNOWN }, -- To commit quickly and view
    { "rhysd/committia.vim",    cond = IS_KNOWN },
    { "kdheepak/lazygit.nvim",  cond = IS_KNOWN and EXECUTABLE("lazygit") },
    {
        "ruifm/gitlinker.nvim",
        config = function()
            require("gitlinker").setup()
        end,
    }, -- Quickly get a permalink to lines of code
    -- My plugins
    "engeir/githistory-browse.nvim",
}
