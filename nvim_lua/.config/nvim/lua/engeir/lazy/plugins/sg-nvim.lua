return {
    "sourcegraph/sg.nvim",
    enabled = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
    event = { "BufReadPre", "BufNewFile" },
    -- -- If you have a recent version of lazy.nvim, you don't need to add this!
    -- build = "nvim -l build/init.lua",
}
