return {

    "renerocksai/telekasten.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "renerocksai/calendar-vim" },
    opts = {
        home = vim.fn.expand("~/projects/notes"), -- Put the name of your notes directory here
    },
}