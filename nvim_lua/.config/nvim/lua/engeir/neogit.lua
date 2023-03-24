local ok, neogit = pcall(require, "neogit")
if not ok then
    return
end

neogit.setup({
    integrations = {
        diffview = true,
    },
})

vim.keymap.set("n", "<leader>gs", neogit.open, { desc = "Neogit Open" })
vim.keymap.set("n", "<leader>gc", function()
    neogit.open({ "commit" })
end, { desc = "Neogit Commit" })
