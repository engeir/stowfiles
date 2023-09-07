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

-- From https://www.reddit.com/r/neovim/comments/16b0n3a/whats_your_new_favorite_functions_share_em/
-- Open files with preferred program
local augroup = vim.api.nvim_create_augroup("user-autocmds", { clear = true })
local intercept_file_open = true
vim.api.nvim_create_user_command("InterceptToggle", function()
    intercept_file_open = not intercept_file_open
    local intercept_state = "`Enabled`"
    if not intercept_file_open then
        intercept_state = "`Disabled`"
    end
    vim.notify("Intercept file open set to " .. intercept_state, vim.log.levels.INFO, {
        title = "Intercept File Open",
        ---@param win integer The window handle
        on_open = function(win)
            vim.api.nvim_buf_set_option(vim.api.nvim_win_get_buf(win), "filetype", "markdown")
        end,
    })
end, { desc = "Toggles intercepting BufNew to open files in custom programs" })

-- NOTE: Add "BufReadPre" to the autocmd events to also intercept files given on the command line, e.g.
-- `nvim myfile.txt`
vim.api.nvim_create_autocmd({ "BufNew", "BufReadPre" }, {
    group = augroup,
    callback = function(args)
        ---@type string
        local path = args.match
        ---@type integer
        local bufnr = args.buf

        ---@type string? The file extension if detected
        local extension = vim.fn.fnamemodify(path, ":e")
        ---@type string? The filename if detected
        local filename = vim.fn.fnamemodify(path, ":t")

        ---Open a given file path in a given program and remove the buffer for the file.
        ---@param buf integer The buffer handle for the opening buffer
        ---@param fpath string The file path given to the program
        ---@param fname string The file name used in notifications
        ---@param prog string The program to execute against the file path
        local function open_in_prog(buf, fpath, fname, prog)
            vim.notify(string.format("Opening `%s` in `%s`", fname, prog), vim.log.levels.INFO, {
                title = "Open File in External Program",
                ---@param win integer The window handle
                on_open = function(win)
                    vim.api.nvim_buf_set_option(vim.api.nvim_win_get_buf(win), "filetype", "markdown")
                end,
            })
            vim.system({ prog, fpath }, { detach = true })
            -- WARN: If you are not on nightly (<0.10), remove the line above and uncomment the line below
            -- vim.fn.jobstart("prog " .. fpath, { detach = true })
            vim.api.nvim_buf_delete(buf, { force = true })
        end

        local extension_callbacks = {
            ["pdf"] = function(buf, fpath, fname)
                open_in_prog(buf, fpath, fname, "zathura")
            end,
            ["png"] = function(buf, fpath, fname)
                open_in_prog(buf, fpath, fname, "nsxiv")
            end,
            ["jpg"] = "png",
            ["mp4"] = function(buf, fpath, fname)
                open_in_prog(buf, fpath, fname, "mpv")
            end,
            ["gif"] = "mp4",
        }

        ---Get the extension callback for a given extension. Will do a recursive lookup if an extension callback is actually
        ---of type string to get the correct extension
        ---@param ext string A file extension. Example: `png`.
        ---@return fun(bufnr: integer, path: string, filename: string?) extension_callback The extension callback to invoke, expects a buffer handle, file path, and filename.
        local function extension_lookup(ext)
            local callback = extension_callbacks[ext]
            if type(callback) == "string" then
                callback = extension_lookup(callback)
            end
            return callback
        end

        if extension ~= nil and not extension:match("^%s*$") and intercept_file_open then
            local callback = extension_lookup(extension)
            if type(callback) == "function" then
                callback(bufnr, path, filename)
            end
        end
    end,
})

-- Make an f-string when typing {
-- Treesitter automatic Python format strings
vim.api.nvim_create_augroup("py-fstring", { clear = true })
vim.api.nvim_create_autocmd("InsertCharPre", {
    pattern = { "*.py" },
    group = "py-fstring",
    --- @param opts AutoCmdCallbackOpts
    --- @return nil
    callback = function(opts)
        -- Only run if f-string escape character is typed
        if vim.v.char ~= "{" then
            return
        end

        -- Get node and return early if not in a string
        local node = vim.treesitter.get_node()

        if not node then
            return
        end
        if node:type() ~= "string" then
            node = node:parent()
        end
        if not node or node:type() ~= "string" then
            return
        end

        vim.print(node:type())
        local row, col, _, _ = vim.treesitter.get_node_range(node)

        -- Return early if string is already a format string
        local first_char = vim.api.nvim_buf_get_text(opts.buf, row, col, row, col + 1, {})[1]
        vim.print("row " .. row .. " col " .. col)
        vim.print("char: '" .. first_char .. "'")
        if first_char == "f" then
            return
        end

        -- Otherwise, make the string a format string
        vim.api.nvim_input("<Esc>m'" .. row + 1 .. "gg" .. col + 1 .. "|if<Esc>`'la")
    end,
})
