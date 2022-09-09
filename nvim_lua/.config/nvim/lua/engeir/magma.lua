local keymap = vim.keymap.set
local opts = { silent = true, noremap = true }

keymap("n", "<localleader>r", ":MagmaEvaluateOperator<cr>", opts)
keymap("n", "<localleader>rr", ":MagmaEvaluateLine<cr>", opts)
keymap("x", "<localleader>r", "<c-u>MagmaEvaluateVisual<cr>", opts)
keymap("n", "<localleader>rc", ":MagmaReevaluateCell<cr>", opts)
keymap("n", "<localleader>rd", ":MagmaDelete<cr>", opts)
keymap("n", "<localleader>ro", ":MagmaShowOutput<cr>", opts)

vim.g.magma_automatically_open_output = false
vim.g.magma_image_provider = "ueberzug"
