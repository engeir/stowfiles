return {
    "FeiyouG/commander.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    opts = {
        integration = {
            lazy = {
                enable = true,
            },
            telescope = {
                enable = true,
                -- Optional, you can use any telescope supported theme
                theme = require("telescope.themes").commander,
            },
        },
    },
}
