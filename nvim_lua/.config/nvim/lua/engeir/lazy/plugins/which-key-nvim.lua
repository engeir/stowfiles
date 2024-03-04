return {
    "folke/which-key.nvim",
    enabled = true,
    event = "VimEnter",
    -- init = function()
    --     vim.o.timeout = true
    --     vim.o.timeoutlen = 300
    -- end,
    config = function() -- This is the function that runs, AFTER loading
        require("which-key").setup()

        -- Document existing key chains
        require("which-key").register({
            -- ["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
            -- ["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
            -- ["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
            ["<leader>f"] = { name = "[F]ind", _ = "which_key_ignore" },
            ["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
        })
    end,
}
