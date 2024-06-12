-- Silent keymap option
local opts = { silent = true, noremap = true }

-- Remap space as leader key
vim.keymap.set("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Undo with "U" (the default "U" behaviour is confusing and I never use it)
vim.keymap.set("n", "U", "<C-r>")

-- Improving default keys
vim.keymap.set("n", "J", function()
  vim.cmd("normal! mzJ")

  local col = vim.fn.col(".")
  local context = string.sub(vim.fn.getline("."), col - 1, col + 1)
  if
    context == ") ."
    or context == ") :"
    or context:match("%( .")
    or context:match(". ,")
    or context:match("%w %.")
  then
    vim.cmd("undojoin | normal! x")
  elseif context == ",)" then
    vim.cmd("undojoin | normal! hx")
  end

  vim.cmd("normal! `z")
end)
-- Never yank empty lines
vim.keymap.set("n", "dd", function()
  if vim.api.nvim_get_current_line():match("^%s*$") then
    return '"_dd'
  else
    return "dd"
  end
end, { expr = true })
-- -- Indent similar to 'o'/'O' (this is broken)
-- vim.keymap.set("n", "i", function()
--     if #vim.fn.getline(".") == 0 then
--         return [["_cc]]
--     else
--         return "i"
--     end
-- end, { expr = true })

-- Open/close the quickfix window
-- vim.keymap.set("n", "<leader>cc", ":cclose<cr>", { desc = "Close Quickfix" })
vim.keymap.set("n", "<leader>co", ":copen<cr>", { desc = "Open Quickfix" })

-- Paste, yank, delete with(out) global clipboard (theprimeagen and asbjornHaland)
vim.keymap.set("x", "<leader>p", '"_dP')
-- These are useful only if you don't have global clipboard by default (I think!)
-- vim.keymap.set("n", "<leader>y", "\"+y")
-- vim.keymap.set("v", "<leader>y", "\"+y")
-- vim.keymap.set("n", "<leader>Y", "\"+Y")
vim.keymap.set({ "v", "n" }, "<leader>d", '"_d')

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
vim.keymap.set(
  "n",
  "<leader>n",
  ':<C-u>call append(line("."),   repeat([""], v:count1))<CR>',
  opts
)
vim.keymap.set(
  "n",
  "<leader>N",
  ':<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>',
  opts
)

-- Spelling
-- nnoremap <silent><leader>s :set spell spelllang=en_gb<CR>
-- nnoremap <silent><leader>S :set spell!<CR>
vim.keymap.set("i", "<C-h>", "<C-G>u<Esc>[s1z=`]a<C-G>u", {
  silent = true,
  noremap = true,
  desc = "Accept first spelling on previous misspelled word.",
})

-- Search, highlight and move
vim.keymap.set(
  "n",
  "<leader>zw",
  "<Cmd>%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
  { desc = "[Z]wap [W]ords" }
)
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)
-- vim.keymap.set("n", "J", "mzJ`z", opts)
vim.keymap.set("n", "{", "{zz", opts)
vim.keymap.set("n", "}", "}zz", opts)
vim.keymap.set(
  "c",
  "<C-s>",
  "\\_s\\s*",
  { desc = "Continue searching on the next line and swallow whitespace" }
)
vim.keymap.set("n", "<leader>v", "<C-v>$")

-- Evaluate math
vim.keymap.set("x", "<leader><leader>e", 'c<C-R>=py3eval(@")<CR><Esc>')
-- vim.keymap.set("x", "<leader><leader>e", 'c<C-R>=eval(@")<CR><Esc>')

-- Running and compiling code
if vim.fn.executable("autocomp") then
  vim.keymap.set(
    "n",
    "<leader>ac",
    "<Cmd>!setsid autocomp % &<CR><CR>",
    { desc = "Toggle custom [a]uto [c]ompiler" }
  )
end
if vim.fn.executable("open_output") then
  vim.keymap.set(
    "n",
    "<leader><leader>o",
    "<Cmd>!open_output % &<CR><CR>",
    { desc = "[O]pen compiled output (not robust)" }
  )
end
