return {
    "nat-418/boole.nvim",
    event = {"BufReadPre", "BufNewFile"},
    cond = IS_KNOWN,
    opts = {
        mappings = {
            increment = "<C-a>",
            decrement = "<C-x>",
        },
        -- User defined loops
        additions = {
            { "Foo",    "Bar" },
            { "enable", "disable" },
            { "left",   "right" },
            { "tic",    "tac",    "toe" },
        },
    },
}
