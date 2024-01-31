return {
    "anuvyklack/hydra.nvim",
    event = { "BufReadPre", "BufNewFile" },
    enabled = true,
    dependencies = {
        { "echasnovski/mini.bracketed" },
        -- { "nvim-telescope/telescope.nvim" },
        -- { "mbbill/undotree" },
    },
    config = function()
        local Hydra = require("hydra")
        -- local cmd = require("hydra.keymap-util").cmd

        --         local hint_telescope = [[
        --                  _f_: files       _m_: marks
        --    🭇🬭🬭🬭🬭🬭🬭🬭🬭🬼    _o_: old files   _g_: live grep
        --   🭉🭁🭠🭘    🭣🭕🭌🬾   _p_: projects    _/_: search in file
        --   🭅█ ▁     █🭐
        --   ██🬿      🭊██   _r_: resume      _u_: undotree
        --  🭋█🬝🮄🮄🮄🮄🮄🮄🮄🮄🬆█🭀  _h_: vim help    _c_: execute command
        --  🭤🭒🬺🬹🬱🬭🬭🬭🬭🬵🬹🬹🭝🭙  _k_: keymaps     _;_: commands history
        --                  _O_: options     _?_: search history
        --  ^
        --                  _<Enter>_: Telescope           _<Esc>_
        -- ]]

        -- Hydra({
        --     name = "Telescope",
        --     hint = hint_telescope,
        --     config = {
        --         color = "teal",
        --         invoke_on_body = true,
        --         hint = {
        --             position = "middle",
        --             border = "rounded",
        --         },
        --     },
        --     mode = "n",
        --     body = "<Leader>f",
        --     heads = {
        --         { "f", cmd("Telescope find_files") },
        --         { "g", cmd("Telescope live_grep") },
        --         { "o", cmd("Telescope oldfiles"), { desc = "recently opened files" } },
        --         { "h", cmd("Telescope help_tags"), { desc = "vim help" } },
        --         -- { "m",       cmd("MarksListBuf"),                        { desc = "marks" } },
        --         { "k", cmd("Telescope keymaps") },
        --         { "O", cmd("Telescope vim_options") },
        --         { "r", cmd("Telescope resume") },
        --         { "p", cmd("Telescope projects"), { desc = "projects" } },
        --         { "/", cmd("Telescope current_buffer_fuzzy_find"), { desc = "search in file" } },
        --         { "?", cmd("Telescope search_history"), { desc = "search history" } },
        --         { ";", cmd("Telescope command_history"), { desc = "command-line history" } },
        --         { "c", cmd("Telescope commands"), { desc = "execute command" } },
        --         { "u", cmd("silent! %foldopen! | UndotreeToggle"), { desc = "undotree" } },
        --         { "<Enter>", cmd("Telescope"), { exit = true, desc = "list all pickers" } },
        --         { "<Esc>", nil, { exit = true, nowait = true } },
        --     },
        -- })
        Hydra({
            name = "Window adjust",
            mode = "n",
            body = "<C-w>",
            heads = {
                { "<", "<C-w><" },
                { ">", "<C-w>>", { desc = "←/→" } },
                { "+", "<C-w>+" },
                { "-", "<C-w>-", { desc = "+/-" } },
                { "j", "<C-w>j" },
                { "k", "<C-w>k", { desc = "/" } },
                { "h", "<C-w>h" },
                { "l", "<C-w>l", { desc = "←/→" } },
            },
        })
        Hydra({
            name = "Next / prev",
            mode = "n",
            body = "]",
            heads = {
                { "b", "<Cmd>lua MiniBracketed.buffer('forward')<CR>" },
                { "B", "<Cmd>lua MiniBracketed.buffer('backward')<CR>", { desc = "Buffer" } },
                { "c", "<Cmd>lua MiniBracketed.comment('forward')<CR>" },
                { "C", "<Cmd>lua MiniBracketed.comment('backward')<CR>", { desc = "Comment" } },
                { "x", "<Cmd>lua MiniBracketed.conflict('forward')<CR>" },
                { "X", "<Cmd>lua MiniBracketed.conflict('backward')<CR>", { desc = "Conflict" } },
                -- { "d", function()
                --     vim.diagnostic.goto_next()
                --     -- vim.diagnostic.open_float()
                -- end },
                -- { "D", function ()
                --     vim.diagnostic.goto_prev()
                --     -- vim.diagnostic.open_float()
                -- end,                            { desc = "Diagnostic" } },
                -- { "d", "<Cmd>lua MiniBracketed.diagnostic('forward')<CR>" },
                -- { "D", "<Cmd>lua MiniBracketed.diagnostic('backward')<CR>", { desc = "Diagnostic" } },
                { "f", "<Cmd>lua MiniBracketed.file('forward')<CR>" },
                { "F", "<Cmd>lua MiniBracketed.file('backward')<CR>", { desc = "File" } },
                -- { "h", "]h" },
                -- { "H", "[H", { desc = "Next/prev hunk" } },
                { "i", "<Cmd>lua MiniBracketed.indent('forward')<CR>" },
                { "I", "<Cmd>lua MiniBracketed.indent('backward')<CR>", { desc = "Indent" } },
                { "j", "<Cmd>lua MiniBracketed.jump('forward')<CR>" },
                { "J", "<Cmd>lua MiniBracketed.jump('forward')<CR>", { desc = "Jump" } },
                { "l", "<Cmd>lua MiniBracketed.location('forward')<CR>" },
                { "L", "<Cmd>lua MiniBracketed.location('backward')<CR>", { desc = "Location" } },
                { "o", "<Cmd>lua MiniBracketed.oldfile('forward')<CR>" },
                { "O", "<Cmd>lua MiniBracketed.oldfile('backward')<CR>", { desc = "Oldfile" } },
                { "q", "<Cmd>lua MiniBracketed.quickfix('forward')<CR>" },
                { "Q", "<Cmd>lua MiniBracketed.quickfix('backward')<CR>", { desc = "Quickfix" } },
                { "t", "<Cmd>lua MiniBracketed.treesitter('forward')<CR>" },
                { "T", "<Cmd>lua MiniBracketed.treesitter('backward')<CR>", { desc = "Tree-sitter" } },
                { "u", "<Cmd>lua MiniBracketed.undo('forward')<CR>" },
                { "U", "<Cmd>lua MiniBracketed.undo('backward')<CR>", { desc = "Undo" } },
                { "w", "<Cmd>lua MiniBracketed.window('forward')<CR>" },
                { "W", "<Cmd>lua MiniBracketed.window('backward')<CR>", { desc = "Window" } },
                { "y", "<Cmd>lua MiniBracketed.yank('forward')<CR>" },
                { "Y", "<Cmd>lua MiniBracketed.yank('backward')<CR>", { desc = "Yank" } },
            },
        })
    end,
}
