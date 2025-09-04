-- Remap space as leader key
vim.keymap.set("", "<Space>", "<Nop>")
vim.g.mapleader = " "

-- Undo with "U" (the default "U" behaviour is confusing and I never use it)
vim.keymap.set("n", "U", "<C-r>", { desc = "Undo" })
-- Save the file with update
vim.keymap.set(
  "n",
  "<C-s>",
  "<cmd>update<CR>",
  { desc = "Save if changes has been made" }
)
-- Forcefully save with `sudo` privileges. Depends on having an executable that `sudo`
-- can use by looking at the `SUDO_ASKPASS` environment variable
vim.api.nvim_create_user_command("W", function()
  local askpass_path = vim.fn.expand("~/bin/askpass-root")
  if vim.fn.filereadable(askpass_path) == 0 then
    vim.notify(
      "Askpass helper not found at " .. askpass_path .. ". Please create it first.",
      vim.log.levels.ERROR
    )
    return
  end
  if vim.fn.executable(askpass_path) == 0 then
    vim.notify(
      "Askpass helper at " .. askpass_path .. " is not executable. Please chmod +x it.",
      vim.log.levels.ERROR
    )
    return
  end
  vim.env.SUDO_ASKPASS = askpass_path
  vim.cmd("w !sudo -A tee % >/dev/null")
  vim.cmd("edit!")
end, { desc = "Write file with sudo using tee" })

-- Close all but the current buffer
vim.keymap.set(
  "n",
  "<leader>bc",
  "<cmd>%bd|e#|bd#<cr>",
  { desc = "Close all but the current buffer" }
)

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
-- Indent similar to 'o'/'O'
vim.keymap.set("n", "i", function()
  if #vim.fn.getline(".") == 0 then
    return [["_cc]]
  else
    return "i"
  end
end, { expr = true })

-- Open/close the quickfix window
-- vim.keymap.set("n", "<leader>cc", ":cclose<cr>", { desc = "Close Quickfix" })
vim.keymap.set("n", "<leader>co", ":copen<cr>", { desc = "Open Quickfix" })

-- Paste, yank, delete with(out) global clipboard (theprimeagen and asbjornHaland)
vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without registering" })
-- These are useful only if you don't have global clipboard by default (I think!)
-- vim.keymap.set("n", "<leader>y", "\"+y")
-- vim.keymap.set("v", "<leader>y", "\"+y")
-- vim.keymap.set("n", "<leader>Y", "\"+Y")
vim.keymap.set(
  { "v", "n" },
  "<leader>d",
  '"_d',
  { desc = "Delete without registering" }
)

-- Move lines
vim.keymap.set("x", "<C-j>", ":move '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("x", "<C-k>", ":move '<-2<CR>gv=gv", { desc = "Move line up" })
-- vim.keymap.set("i", "<C-j>", ":m .+1<CR>==")
-- vim.keymap.set("i", "<C-k>", ":m .-2<CR>==")
-- vim.keymap.set("n", "<leader>j", ":m .+1<CR>==")
-- vim.keymap.set("n", "<leader>k", ":m .-2<CR>==")

-- Indentation
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Add newline below or above
vim.keymap.set(
  "n",
  "<leader>n",
  ':<C-u>call append(line("."),   repeat([""], v:count1))<CR>'
)
vim.keymap.set(
  "n",
  "<leader>N",
  ':<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>'
)

-- Spelling
-- nnoremap <silent><leader>s :set spell spelllang=en_gb<CR>
-- nnoremap <silent><leader>S :set spell!<CR>
vim.keymap.set("i", "<C-h>", "<C-G>u<Esc>[s1z=`]a<C-G>u", {
  silent = true,
  noremap = true,
  desc = "Accept first spelling on previous misspelled word.",
})
vim.keymap.set(
  "n",
  "zng",
  "<cmd>set spelllang=nb<CR>zg<cmd>set spelllang=en_gb,nb<CR>",
  { desc = "zg, but to the Norwegian dictionary" }
)
vim.keymap.set(
  "n",
  "znG",
  "<cmd>set spelllang=nb<CR>zG<cmd>set spelllang=en_gb,nb<CR>",
  { desc = "zG, but to the Norwegian dictionary" }
)

-- Search, highlight and move
vim.keymap.set(
  "n",
  "<leader>zw",
  "<Cmd>%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
  { desc = "[Z]wap [W]ords" }
)
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
-- vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "}", "}zz")
vim.keymap.set(
  "c",
  "<C-s>",
  "\\_s\\s*",
  { desc = "Continue searching on the next line and swallow whitespace" }
)
vim.keymap.set("n", "<leader>v", "<C-v>$")
vim.keymap.set(
  "c",
  "<C-h>",
  "%s/—/-/g",
  { desc = "Continue searching on the next line and swallow whitespace" }
)

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

vim.keymap.set(
  "n",
  "<leader>rn",
  function() vim.cmd([[silent! %s/\\n/\="\r"/g]]) end,
  { desc = "Insert newline for \\n string." }
)
vim.keymap.set(
  "v",
  "<leader>rn",
  function() vim.cmd([[silent! '<,'>s/\\n/\="\r"/g]]) end,
  { desc = "Insert newline for \\n string." }
)
