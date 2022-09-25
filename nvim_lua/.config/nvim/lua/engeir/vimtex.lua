vim.g.tex_flavor = "latex"
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_quickfix_mode = 0

vim.keymap.set("n", "<localleader><localleader>t", ":VimtexTocOpen<CR>", {remap = false, silent = true})
vim.keymap.set("n", "<localleader><localleader>T", ":VimtexTocToggle<CR>", {remap = false, silent = true})
