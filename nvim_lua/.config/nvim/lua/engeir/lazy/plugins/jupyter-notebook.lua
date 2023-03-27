local opts = { silent = true, noremap = true }
return {
    {
        "dccsillag/magma-nvim",
        enabled = false,
        build = ":UpdateRemotePlugins",
        cond = IS_KNOWN and IS_LINUX,
        init = function()
            vim.g.magma_automatically_open_output = false
            vim.g.magma_image_provider = "ueberzug"
        end,
        keys = {
            { "<localleader>r",  ":MagmaEvaluateOperator<cr>",   opts },
            { "<localleader>rr", ":MagmaEvaluateLine<cr>",       opts },
            { "<localleader>r",  "<c-u>MagmaEvaluateVisual<cr>", opts },
            { "<localleader>rc", ":MagmaReevaluateCell<cr>",     opts },
            { "<localleader>rd", ":MagmaDelete<cr>",             opts },
            { "<localleader>ro", ":MagmaShowOutput<cr>",         opts },
        },
    },
    { "goerz/jupytext.vim", enabled = false, cond = IS_KNOWN and IS_LINUX },
}
