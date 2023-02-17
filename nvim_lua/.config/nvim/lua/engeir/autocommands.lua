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

-- Add screenshot capabilities
-- See for example c613d353fbe843d9bdd31f2b2e92a513c0ede755
-- https://github.com/engeir/stowfiles/blob/c613d353fbe843d9bdd31f2b2e92a513c0ede755/nvim/.config/nvim/autoload/dotvim.vim
-- https://github.com/engeir/stowfiles/blob/c613d353fbe843d9bdd31f2b2e92a513c0ede755/nvim/.config/nvim/keys/mappings.vim
-- Neovim API: https://neovim.io/doc/user/lua-guide.html#lua-guide-autocommand-create

-- Augroup for creating and inserting screenshots in text files.
local write_group = vim.api.nvim_create_augroup("WRIGHTING", { clear = true })
local opts = { desc = "Save screenshots to ./assets/images and insert in doc" }
local dir = "./assets/images"
-- autocmd FileType pandoc nnoremap <buffer> cic :call pandoc#after#nrrwrgn#NarrowCodeblock()<cr>
vim.api.nvim_create_autocmd({ "FileType" }, {
    group = write_group,
    pattern = "pandoc",
    command = "nnoremap <buffer> cic :call pandoc#after#nrrwrgn#NarrowCodeblock()<cr>",
})
-- autocmd FileType markdown,pandoc nnoremap <buffer> <leader>i :<C-U>call dotvim#ImportScreenShot(function('dotvim#MarkdownScreenShot'),'.png')
vim.api.nvim_create_autocmd({ "FileType" }, {
    group = write_group,
    pattern = { "markdown", "pandoc" },
    -- command = "nnoremap <buffer> <leader>i :<C-U>call dotvim#ImportScreenShot(function('dotvim#MarkdownScreenShot'),'.png')",
    -- command = "nnoremap <buffer> <leader>i :<C-U>lua=",
    callback = function()
        vim.keymap.set("n", "<leader>i", function()
            vim.api.nvim_set_current_line(dir)
        end, opts)
    end,
})
-- autocmd FileType latex,tex nnoremap <buffer> <leader>i :<C-U>call dotvim#ImportScreenShot(function('dotvim#LatexScreenShot'),'.png')
vim.api.nvim_create_autocmd({ "FileType" }, {
    group = write_group,
    pattern = { "latex", "tex" },
    command = "nnoremap <buffer> <leader>i :<C-U>call dotvim#ImportScreenShot(function('dotvim#LatexScreenShot'),'.png')",
})
-- autocmd FileType dotoo,org nnoremap <buffer> <leader>i       :<C-U>call dotvim#ImportScreenShot(function('dotvim#OrgScreenShot'),'.eps')
vim.api.nvim_create_autocmd({ "FileType" }, {
    group = write_group,
    pattern = { "dotoo", "org" },
    command = "nnoremap <buffer> <leader>i :<C-U>call dotvim#ImportScreenShot(function('dotvim#OrgScreenShot'),'.eps')",
})
-- autocmd FileType groff,troff,nroff nnoremap <buffer> <leader>i     :<C-U>call dotvim#ImportScreenShot(function('dotvim#GroffScreenShot'),'.eps')
vim.api.nvim_create_autocmd({ "FileType" }, {
    group = write_group,
    pattern = { "groff", "troff", "nroff" },
    command = "nnoremap <buffer> <leader>i :<C-U>call dotvim#ImportScreenShot(function('dotvim#GroffScreenShot'),'.eps')",
})
