-- Use 'q' to quit from common plugins
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "lir" },
    callback = function()
        vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]])
    end,
})

-- Close quickfix menu after selecting choice
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "qf" },
    command = [[nnoremap <buffer> <CR> <CR>:cclose<CR>]],
})

-- Remember where you were last time you exited the file.
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Remove statusline and tabline when in Alpha
vim.api.nvim_create_autocmd({ "User" }, {
    pattern = { "AlphaReady" },
    callback = function()
        vim.cmd([[
      set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
      set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
    ]])
    end,
})

-- Set wrap and spell in markdown and gitcommit
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "gitcommit", "tex" },
    callback = function()
        vim.opt_local.wrap = false
        vim.opt_local.spell = true
        vim.opt_local.formatoptions:append("t")
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

-- Enable treesitter highlighting
-- https://this-week-in-neovim.org/2023/Feb/20#core
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "lua", "help", "python" }, -- or { 'lua', 'help' },
    callback = function()
        vim.treesitter.start()
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
vim.cmd("au! Syntax newlang source $HOME/.config/nvim/syntax/ncl.vim")
-- au BufRead,BufNewFile *.ncl set filetype=ncl
-- au! Syntax newlang source $VIM/ncl.vim
