local ok, bufferline = pcall(require, "bufferline")
if not ok then
    return
end

bufferline.setup()

vim.keymap.set("n", "H", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "L", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
