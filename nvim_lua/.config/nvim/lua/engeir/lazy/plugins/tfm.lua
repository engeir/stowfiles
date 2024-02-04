return {
    "rolv-apneseth/tfm.nvim",
    event = "BufReadPost",
    enabled = IS_KNOWN,
    lazy = true,
    opts = {
        -- TFM to use
        -- Possible choices: "ranger" | "nnn" | "lf" | "yazi" (default)
        file_manager = "yazi",
        -- Replace netrw entirely
        -- Default: false
        replace_netrw = true,
        -- Enable creation of commands
        -- Default: false
        -- Commands:
        --   Tfm: selected file(s) will be opened in the current window
        --   TfmSplit: selected file(s) will be opened in a horizontal split
        --   TfmVsplit: selected file(s) will be opened in a vertical split
        --   TfmTabedit: selected file(s) will be opened in a new tab page
        enable_cmds = false,
        -- Custom keybindings only applied within the TFM buffer
        -- Default: {}
        keybindings = {
            ["<ESC>"] = "q",
        },
        -- Customise UI. The below options are the default
        ui = {
            border = "rounded",
            height = 1,
            width = 1,
            x = 0.5,
            y = 0.5,
        },
    },
    keys = {
        {
            "<leader>pt",
            function()
                require("tfm").open()
            end,
            desc = "TFM",
        },
        {
            "<leader>p-",
            function()
                local tfm = require("tfm")
                tfm.open(nil, tfm.OPEN_MODE.split)
            end,
            desc = "TFM - horizonal split",
        },
        {
            "<leader>p|",
            function()
                local tfm = require("tfm")
                tfm.open(nil, tfm.OPEN_MODE.vsplit)
            end,
            desc = "TFM - vertical split",
        },
        {
            "<leader>pw",
            function()
                local tfm = require("tfm")
                tfm.open(nil, tfm.OPEN_MODE.tabedit)
            end,
            desc = "TFM - new tab",
        },
    },
}
