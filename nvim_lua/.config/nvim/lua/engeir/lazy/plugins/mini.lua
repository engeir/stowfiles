return {
    -- mini.nvim
    -- Replaces:
    --    junegunn/vim-easy-align -> mini.align
    --    numToStr/Comment.nvim   -> mini.comment
    --    RRethy/vim-illuminate   -> mini.cursorword
    --    windwp/nvim-autopairs   -> mini.pairs
    --    goolord/alpha-nvim      -> mini.starter
    --    kylechui/nvim-surround  -> mini.surround
    --    folke/flash.nvim        <- mini.jump

    -- mini.ai -------------------------------------------------------------------------
    {
        "echasnovski/mini.ai",
        event = "VeryLazy",
        config = true,
    },

    -- mini.align ----------------------------------------------------------------------
    { "echasnovski/mini.align", config = true },

    -- mini.bracketed ------------------------------------------------------------------
    { "echasnovski/mini.bracketed", config = true },

    -- mini.colors ---------------------------------------------------------------------
    { "echasnovski/mini.colors", cofig = true },

    -- mini.comment --------------------------------------------------------------------
    {
        "echasnovski/mini.comment",
        event = "VeryLazy",
        init = function()
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

            set_comment("mplstyle", "#%s")
            set_comment("ncl", ";%s")
            set_comment("nu", "#%s")
            set_comment("sent", "#%s")
        end,
        config = true,
    },

    -- mini.cursorword -----------------------------------------------------------------
    {
        "echasnovski/mini.cursorword",
        event = { "BufReadPost", "BufNewFile" },
        config = true,
    },

    -- mini.files ----------------------------------------------------------------------
    {
        "echasnovski/mini.files",
        config = true,
        keys = {
            {
                "<leader>pm",
                function()
                    MiniFiles.open(vim.api.nvim_buf_get_name(0))
                end,
                desc = "[P]ath explorer with [M]iniFiles",
            },
        },
    },

    -- mini.fuzzy ----------------------------------------------------------------------
    -- Replaces one of the sorters:
    -- https://github.com/nvim-telescope/telescope.nvim#sorters
    { "echasnovski/mini.fuzzy", config = true },

    -- mini.pairs ----------------------------------------------------------------------
    {
        "echasnovski/mini.pairs",
        event = "VeryLazy",
        config = true,
    },

    -- mini.indentscope ----------------------------------------------------------------
    {
        "echasnovski/mini.indentscope",
        version = false, -- wait till new 0.7.0 release to put it back on semver
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            -- symbol = "▏",
            symbol = "│",
            options = { try_as_border = true },
        },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "help",
                    "alpha",
                    "dashboard",
                    "neo-tree",
                    "Trouble",
                    "lazy",
                    "mason",
                    "notify",
                    "toggleterm",
                    "lazyterm",
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
    },

    -- mini.jump -----------------------------------------------------------------------
    -- Alternative is folke/flash.nvim
    -- require("mini.jump").setup({ delay = { highlight = 10 ^ 7 } })

    -- mini.splitjoin ------------------------------------------------------------------
    { "echasnovski/mini.splitjoin", config = true },

    -- mini.surround -------------------------------------------------------------------
    { "echasnovski/mini.surround", config = true },

    -- mini.starter --------------------------------------------------------------------
    {
        "echasnovski/mini.starter",
        config = function()
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
                    action = "lua require('telescope.builtin').grep_string({search=''})",
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
        end,
    },

    -- mini.trailspace -----------------------------------------------------------------
    {
        "echasnovski/mini.trailspace",
        init = function()
            require("mini.trailspace").setup()
        end,
        keys = {
            {
                "<leader>mt",
                function()
                    require("mini.trailspace").trim()
                    require("mini.trailspace").trim_last_lines()
                end,
                desc = "[M]iniTrailspace [T]rim",
            },
        },
    },
}
