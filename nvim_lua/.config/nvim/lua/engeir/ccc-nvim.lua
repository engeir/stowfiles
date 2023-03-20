local ok, _ = pcall(require, "ccc.input")
if not ok then
    return
end

local opts = { noremap = true, silent = true }
vim.keymap.set({ "i", "n" }, "<C-c>", "<cmd>CccPick<cr>", opts)
