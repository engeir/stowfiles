local status_ok, term = pcall(require, "toggleterm")
if not status_ok then
	return
end

-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true, noremap = true }

-- General toggleterm mappings
function _G.set_terminal_keymaps()
	-- local opts = { noremap = true }
	vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

-- Usage
keymap("n", "<leader>ft", ":ToggleTerm direction=float<CR>", opts)
keymap("n", "<leader>t", ":TermExec size=100 direction=vertical cmd='python'<CR>", opts)
keymap("n", "<leader>pv", ":TermExec close_on_exit=true border=curved direction=float size=90 cmd='nnn -dH'<CR>", opts)
keymap("n", "<leader>H", ":/%%<CR>VN", opts)
keymap("v", "<C-r>", ":'<,'>ToggleTermSendVisualLines <CR>", opts)
keymap("n", "<leader>r", ":TermExec direction=float go_back=0 cmd='compiler %'<CR>", opts)
