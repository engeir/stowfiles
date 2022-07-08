local status_ok, term = pcall(require, "toggleterm")
if not status_ok then
    return
end
term.setup({ shade_terminals = true })

-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true, noremap = true }

-- Usage
keymap("n", "<leader>ft", ":ToggleTerm direction=float<CR>", opts)
keymap("n", "<leader>t", ":TermExec size=100 direction=vertical cmd='python'<CR>", opts)
keymap("n", "<leader>pv", ":TermExec close_on_exit=true border=curved direction=float size=90 cmd='nnn -dH'<CR>", opts)
keymap("n", "<leader>H", ":/%%<CR>VN", opts)
keymap("v", "<C-r>", ":'<,'>ToggleTermSendVisualLines <CR>", opts)
keymap("n", "<leader>r", ":TermExec direction=float go_back=0 cmd='compiler %'<CR>", opts)
