vim.g.mapleader = " "
vim.cmd[[au TextYankPost * silent! lua vim.highlight.on_yank()]]
require("engeir.plugins")
require("engeir.settings")
