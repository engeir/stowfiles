local ok, diffview = pcall(require, "diffview")
if not ok then
    return
end

diffview.setup()

local opts = { silent = true, noremap = true }
vim.keymap.set("n", "dc", ":DiffviewClose<cr>", opts)
vim.keymap.set("n", "do", ":DiffviewOpen<cr>", opts)
