local map = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
-- local cmd = vim.cmd

map('n', '<leader>hf', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', default_opts)
map('n', '<leader>hm', '<cmd>lua require("harpoon.mark").add_file()<CR>', default_opts)
map('n', '<leader>hn', '<cmd>lua require("harpoon.ui").nav_next()<CR>', default_opts)
map('n', '<leader>hN', '<cmd>lua require("harpoon.ui").nav_prev()<CR>', default_opts)
