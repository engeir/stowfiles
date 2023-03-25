-- [[ I'm using mini.nvim instead ]]
local opts = { silent = true, noremap = true }
vim.g.easy_align_ignore_groups = { "Comment", "String" }
return {
    "junegunn/vim-easy-align",
    enabled = false,
    opts = {},
    keys = {
        { "n", "ga", "<Plug>(EasyAlign)", opts, desc = "EasyAlign" },
        { "x", "ga", "<Plug>(EasyAlign)", opts, desc = "EasyAlign" },
    },
}
