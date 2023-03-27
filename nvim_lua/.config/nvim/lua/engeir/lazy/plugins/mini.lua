return {
    -- mini.nvim
    -- Replaces:
    --    junegunn/vim-easy-align -> mini.align
    --    numToStr/Comment.nvim   -> mini.comment
    --    RRethy/vim-illuminate   -> mini.cursorword
    --    windwp/nvim-autopairs   -> mini.pairs
    --    goolord/alpha-nvim      -> mini.starter
    --    kylechui/nvim-surround  -> mini.surround
    "echasnovski/mini.nvim",
    config = function()
        -- mini.ai ---------------------------------------------------------------------
        require("mini.ai").setup()

        -- mini.align ------------------------------------------------------------------
        require("mini.align").setup()

        -- mini.bracketed --------------------------------------------------------------
        require("mini.bracketed").setup()

        -- mini.comment ----------------------------------------------------------------
        require("mini.comment").setup()
        --- Set the comment rule for a file type
        ---@param pattern string
        ---@param c_string string
        local function set_comment(pattern, c_string)
            vim.api.nvim_create_autocmd("FileType", {
                pattern = pattern,
                callback = function()
                    vim.opt_local.commentstring = c_string
                end,
            })
        end

        set_comment("ncl", ";%s")
        set_comment("sent", "#%s")

        -- mini.cursorword -------------------------------------------------------------
        require("mini.cursorword").setup()

        -- mini.pairs ------------------------------------------------------------------
        require("mini.pairs").setup()

        -- mini.indentscope ------------------------------------------------------------
        require("mini.indentscope").setup()

        -- mini.jump -------------------------------------------------------------------
        require("mini.jump").setup({ delay = { highlight = 10 ^ 7 } })

        -- mini.splitjoin --------------------------------------------------------------
        require("mini.splitjoin").setup()

        -- mini.surround ---------------------------------------------------------------
        require("mini.surround").setup()

        -- mini.starter ----------------------------------------------------------------
        local starter = require("mini.starter")
        local function footer()
            -- NOTE: requires the fortune-mod package to work
            -- local handle = io.popen("fortune")
            -- local fortune = handle:read("*a")
            -- handle:close()
            -- return fortune
            local handle = io.popen("nvim --version")
            if handle == nil then
                return "Nvim Config by @engeir"
            end
            local result = "Config by @engeir — " .. string.match(handle:read("*a"), "NVIM v[^\n]*")
            handle:close()
            return result
        end

        local my_telescope = {
            {
                name = "All files",
                action = "lua require('telescope.builtin').find_files({hidden=true})",
                section = "Telescope",
            },
            {
                name = "Git files",
                action = "lua require'engeir.lazy.telescope.telescope-extra'.project_files()",
                section = "Telescope",
            },
            {
                name = "Old files",
                action = "Telescope oldfiles",
                section = "Telescope",
            },
            {
                name = "Live grep",
                action = "Telescope live_grep",
                section = "Telescope",
            },
            {
                name = "Command history",
                action = "Telescope command_history",
                section = "Telescope",
            },
            {
                name = "Help tags",
                action = "Telescope help_tags",
                section = "Telescope",
            },
        }
        local items = {
            my_telescope,
            starter.sections.recent_files(5, true, true),
            starter.sections.recent_files(5, false, true),
            {
                name = "Open TODO",
                action = ":e ~/Documents/notes_papers/_includes/todo.md",
                section = "Builtin actions",
            },
            starter.sections.builtin_actions(),
        }
        local content_hooks = {
            starter.gen_hook.adding_bullet(),
            starter.gen_hook.indexing("all", { "Builtin actions", "Telescope" }),
            starter.gen_hook.aligning("center", "center"),
        }
        local starter_opts = {
            items = items,
            content_hooks = content_hooks,
            header = [[
                  ██╗
                ██╔═██╗
      ██████╗   ██║ ██║ ██╗
      ╚═════╝   ╚═██╔═╝ ██║
    ██████╗   ██████████╔═╝
    ╚═════╝   ██╔═██╔═══╝
    ██████╗   ██║ ██║
    ╚═════╝   ╚═╝ ██║
    ██████╗ ████╗ ██████╗
    ╚═════╝ ╚═██║ ██║ ██║
      ██████╗ ██████║ ██║
      ╚═════╝ ╚═════╝ ████╗
                      ╚═══╝
]],
            footer = footer(),
        }
        starter.setup(starter_opts)

        -- mini.trailspace -------------------------------------------------------------
        require("mini.trailspace").setup()
    end,
}
