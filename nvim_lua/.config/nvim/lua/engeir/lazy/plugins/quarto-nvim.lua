return {
    -- {
    --     "quarto-dev/quarto-nvim",
    --     dev = false,
    --     -- dependencies = {
    --     --   {
    --     --     "jmbuhr/otter.nvim",
    --     --     dev = false,
    --     --     dependencies = {
    --     --       { "neovim/nvim-lspconfig" },
    --     --     },
    --     --     opts = {
    --     --       lsp = {
    --     --         hover = {
    --     --           border = require("misc.style").border,
    --     --         },
    --     --       },
    --     --       buffers = {
    --     --         -- if set to true, the filetype of the otterbuffers will be set.
    --     --         -- otherwise only the autocommand of lspconfig that attaches
    --     --         -- the language server will be executed without setting the filetype
    --     --         set_filetype = true,
    --     --       },
    --     --     },
    --     --   },
    --     -- },
    --     opts = {
    --         lspFeatures = {
    --             languages = { "r", "python", "julia", "bash", "lua", "html" },
    --         },
    --     },
    -- },
    {
        "quarto-dev/quarto-nvim",
        -- enabled = false,
        enabled = IS_KNOWN,
        ft = { "quarto" },
        dependencies = {
            { "jpalardy/vim-slime" },
            { "ekickx/clipboard-image.nvim" },
        },
        config = function()
            require("quarto").setup({
                debug = false,
                closePreviewOnExit = true,
                lspFeatures = {
                    enabled = true,
                    languages = { "r", "python", "julia", "bash" },
                    chunks = "curly", -- 'curly' or 'all'
                    diagnostics = {
                        enabled = true,
                        triggers = { "BufWritePost" },
                    },
                    completion = {
                        enabled = true,
                    },
                },
                keymap = {
                    hover = "K",
                    definition = "gd",
                    rename = "<leader>rn",
                    references = "gr",
                },
            })
        end,
    },
}
