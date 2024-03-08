return {
    {
        "zbirenbaum/copilot.lua",
        enabled = true,
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                filetypes = { markdown = true },
                panel = {
                    enabled = false,
                    auto_refresh = true,
                    keymap = {
                        jump_prev = "[[",
                        jump_next = "]]",
                        accept = "<CR>",
                        refresh = "gr",
                        open = "<M-CR>",
                    },
                    layout = {
                        position = "right", -- | bottom | top | left | right
                        ratio = 0.4,
                    },
                },
                suggestion = {
                    enabled = true,
                    autotrigger = true,
                    keymap = {
                        next = "<M-k>",
                        prev = "<M-j>",
                    },
                },
            })
        end,
    },
    { "github/copilot.vim", enabled = false, event = "InsertEnter" },
    {
        "zbirenbaum/copilot-cmp",
        enabled = true,
        config = function()
            require("copilot_cmp").setup()
        end,
    },
}
