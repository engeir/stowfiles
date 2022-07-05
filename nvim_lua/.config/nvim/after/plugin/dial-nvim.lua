local ok, dial = pcall(require, "dial.map")
if not ok then
    return
end

vim.api.nvim_set_keymap("n", "<C-a>", dial.inc_normal(), {noremap = true})
vim.api.nvim_set_keymap("n", "<C-x>", dial.dec_normal(), {noremap = true})
vim.api.nvim_set_keymap("v", "<C-a>", dial.inc_visual(), {noremap = true})
vim.api.nvim_set_keymap("v", "<C-x>", dial.dec_visual(), {noremap = true})
vim.api.nvim_set_keymap("v", "g<C-a>", dial.inc_gvisual(), {noremap = true})
vim.api.nvim_set_keymap("v", "g<C-x>", dial.dec_gvisual(), {noremap = true})
