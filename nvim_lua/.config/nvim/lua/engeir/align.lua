-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true, noremap = true }
keymap("n", "ga", "<Plug>(EasyAlign)", opts)
keymap("x", "ga", "<Plug>(EasyAlign)", opts)

vim.g.easy_align_ignore_groups = {"Comment", "String"}
