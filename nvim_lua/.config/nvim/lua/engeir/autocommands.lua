-- Use 'q' to quit from common plugins
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "lir" },
    callback = function()
        vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]]   )
    end,
})

-- Remove statusline and tabline when in Alpha
vim.api.nvim_create_autocmd({ "User" }, {
    pattern = { "AlphaReady" },
    callback = function()
        vim.cmd([[
      set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
      set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
    ]]   )
    end,
})

-- Set wrap and spell in markdown and gitcommit
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "gitcommit" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

vim.cmd("autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif")

-- Fixes Autocomment
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    callback = function()
        vim.cmd("set formatoptions-=cro")
    end,
})

-- Highlight Yanked Text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    callback = function()
        vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
    end,
})

-- -- Give syntax highlight to `.ncl` files
-- local set_filetype_ncl = function()
--     vim.opt.filetype:append("ncl")
-- end
-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
--     pattern = "*.ncl",
--     callback = set_filetype_ncl,
-- })
-- local vim_set_ncl = "source /home/een023/.config/nvim/syntax/ncl.vim"
-- vim.api.nvim_create_autocmd("Syntax", {
--     pattern = "newlang",
--     callback = vim_set_ncl,
-- })
vim.cmd("au BufRead,BufNewFile *.ncl set filetype=ncl")
vim.cmd("au! Syntax newlang source $VIM/ncl.vim")
-- au BufRead,BufNewFile *.ncl set filetype=ncl
-- au! Syntax newlang source $VIM/ncl.vim
