return {
    "nat-418/boole.nvim",
    cond = IS_KNOWN,
    opts = {
        mappings = {
            increment = "<C-a>",
            decrement = "<C-x>",
        },
        -- User defined loops
        additions = {
            { "Foo", "Bar" },
            { "tic", "tac", "toe" },
        },
    },
}