local executable = function(x)
  return vim.fn.executable(x) == 1
end

-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Move lines
keymap("x", "J", ":move '>+1<CR>gv=gv")
keymap("x", "K", ":move '<-2<CR>gv=gv")
-- keymap("i", "<C-j>", ":m .+1<CR>==")
-- keymap("i", "<C-k>", ":m .-2<CR>==")
keymap("n", "<leader>j", ":m .+1<CR>==")
keymap("n", "<leader>k", ":m .-2<CR>==")
-- Tabs
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")
-- Add space
keymap("n", "<leader>n", ':<C-u>call append(line("."),   repeat([""], v:count1))<CR>', opts)
keymap("n", "<leader>N", ':<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>', opts)

-- Spelling
-- nnoremap <silent><leader>s :set spell spelllang=en_gb<CR>
-- nnoremap <silent><leader>S :set spell!<CR>
keymap("i", "<C-l>", "<C-G>u<Esc>[s1z=`]a<C-G>u")

-- Search and highlight
keymap("n", "<leader>h", ":noh<CR>", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)
-- keymap("n", "J", "mzJ`z", opts)
keymap("n", "{", "{zz", opts)
keymap("n", "}", "}zz", opts)

-- Running and compiling code
if executable "autocomp" then
    keymap("n", "<leader>a", ":!setsid autocomp % &<CR>", opts)
end
if executable "open_output" then
    keymap("n", "<leader><leader>o", ":!open_output % &<CR>", opts)
end
