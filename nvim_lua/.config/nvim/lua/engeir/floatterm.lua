-- local status_ok, term = pcall(require, "vim-floaterm")
-- if not status_ok then
--     return
-- end

vim.g.floaterm_width = 0.45

-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true, noremap = true }

keymap("n", "<leader>ft", "FloatermToggle", opts)
keymap("n", "<leader>t", ":FloatermNew --wintype=vsplit --autohide=0 python<CR><C-\\><C-n><C-w>h", opts)
keymap("n", "<leader>pv", ":FloatermNew --wintype=float --position=right --autoclose=2 nnn -dH<CR>", opts)
keymap("n", "<leader>H", ":/%%<CR>VN", opts)
keymap("v", "<C-r>", ":'<,'>FloatermSend <CR>", opts)
keymap("n", "<leader>r", ":FloatermNew --wintype=float --position=right --autoclose=0 compiler %<CR>", opts)
keymap("n", "<leader>tn", ":FloatermNext <CR>", opts)
keymap("n", "<leader>tp", ":FloatermPrev <CR>", opts)
keymap("n", "<leader>th", ":FloatermHide <CR>", opts)
