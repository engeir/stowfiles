-- Silent keymap option
local opts = { silent = true, noremap = true }

-- Remap space as leader key
vim.keymap.set("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Paste, yank, delete with(out) global clipboard (theprimeagen and asbjornHaland)
vim.keymap.set("x", "<leader>p", '"_dP')
-- These are useful only if you don't have global clipboard by default (I think!)
-- vim.keymap.set("n", "<leader>y", "\"+y")
-- vim.keymap.set("v", "<leader>y", "\"+y")
-- vim.keymap.set("n", "<leader>Y", "\"+Y")
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')

-- Move lines
vim.keymap.set("x", "J", ":move '>+1<CR>gv=gv")
vim.keymap.set("x", "K", ":move '<-2<CR>gv=gv")
-- vim.keymap.set("i", "<C-j>", ":m .+1<CR>==")
-- vim.keymap.set("i", "<C-k>", ":m .-2<CR>==")
-- vim.keymap.set("n", "<leader>j", ":m .+1<CR>==")
-- vim.keymap.set("n", "<leader>k", ":m .-2<CR>==")

-- Tabs
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Add newline below or above
vim.keymap.set("n", "<leader>n", ':<C-u>call append(line("."),   repeat([""], v:count1))<CR>', opts)
vim.keymap.set("n", "<leader>N", ':<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>', opts)

-- Spelling
-- nnoremap <silent><leader>s :set spell spelllang=en_gb<CR>
-- nnoremap <silent><leader>S :set spell!<CR>
vim.keymap.set(
    "i",
    "<C-M>",
    "<C-G>u<Esc>[s1z=`]a<C-G>u",
    { silent = true, noremap = true, desc = "Accept first spelling on previous misspelled word." }
)

-- Search, highlight and move
vim.keymap.set("n", "<leader>zw", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "[Z]wap [W]ords" })
vim.keymap.set("n", "<leader>h", ":noh<CR>", opts)
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)
-- vim.keymap.set("n", "J", "mzJ`z", opts)
vim.keymap.set("n", "{", "{zz", opts)
vim.keymap.set("n", "}", "}zz", opts)

-- Evaluate math
vim.keymap.set("x", "<leader><leader>e", 'c<C-R>=py3eval(@")<CR><Esc>')
-- vim.keymap.set("x", "<leader><leader>e", 'c<C-R>=eval(@")<CR><Esc>')

-- Running and compiling code
if EXECUTABLE("autocomp") then
    vim.keymap.set("n", "<leader>a", ":!setsid autocomp % &<CR>", opts)
end
if EXECUTABLE("open_output") then
    vim.keymap.set("n", "<leader><leader>o", ":!open_output % &<CR>", opts)
end
