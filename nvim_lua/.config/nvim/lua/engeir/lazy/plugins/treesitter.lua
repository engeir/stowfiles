return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "bash",
                    "bibtex",
                    "css",
                    "fortran",
                    "go",
                    "html",
                    "latex",
                    "lua",
                    "markdown",
                    "markdown_inline",
                    -- "norg",
                    -- "org",
                    "python",
                    "scss",
                    "toml",
                    "vim",
                },
                sync_install = false,
                auto_install = false,
                ignore_install = {},
                rainbow = {
                    enable = true,
                    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
                    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
                    max_file_lines = nil, -- Do not enable for files with more than n lines, int
                    -- colors = {}, -- table of hex strings
                    -- termcolors = {} -- table of colour name strings
                },
                modules = { "highlight", "indent", "incremental_selection", "textobjects" },
                indent = { enable = true },
                highlight = {
                    enable = true,
                    -- disable = {"markdown"},
                    custom_captures = {
                        -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
                        ["foo.bar"] = "Identifier",
                    },
                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                    -- Using this option may slow down your editor, and you may see some duplicate highlights.
                    -- Instead of true it can also be a list of languages
                    additional_vim_regex_highlighting = false, --{
                    -- "bash",
                    -- "go",
                    -- "latex",
                    -- "lua",
                    -- "markdown",
                    -- "python",
                    -- "toml",
                    -- "vim",
                    -- }, -- Spell check only in comments, not code, for the given languages
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<c-n>",
                        node_incremental = "<c-n>",
                        scope_incremental = "<c-s>",
                        node_decremental = "<c-m>",
                    },
                },
                textobjects = {
                    enable = true,
                    select = {
                        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ["aa"] = "@parameter.outer",
                            ["ia"] = "@parameter.inner",
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            ["]m"] = "@function.outer",
                            ["]]"] = "@class.outer",
                        },
                        goto_next_end = {
                            ["]M"] = "@function.outer",
                            ["]["] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["[m"] = "@function.outer",
                            ["[["] = "@class.outer",
                        },
                        goto_previous_end = {
                            ["[M"] = "@function.outer",
                            ["[]"] = "@class.outer",
                        },
                    },
                    swap = {
                        enable = true,
                        -- These does not cover all edge cases, so
                        -- "ziontee113/syntax-tree-surfer" is used along side, see
                        -- config further down
                        swap_next = {
                            ["]n"] = "@parameter.inner",
                        },
                        swap_previous = {
                            ["[n"] = "@parameter.inner",
                        },
                    },
                },
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
            require("treesitter-context").setup({
                min_window_height = 0,
                line_numbers = true,
                multiline_threshold = 15,
                enable = true,        -- Enable this plugin (Can be enabled/disabled later via commands)
                max_lines = 0,        -- How many lines the window should span. Values <= 0 mean no limit.
                trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
                patterns = {
                    -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
                    -- For all filetypes
                    -- Note that setting an entry here replaces all other patterns for this entry.
                    -- By setting the 'default' entry below, you can control which nodes you want to
                    -- appear in the context window.
                    default = {
                        "class",
                        "function",
                        "method",
                        -- 'for', -- These won't appear in the context
                        -- 'while',
                        -- 'if',
                        -- 'switch',
                        -- 'case',
                    },
                    -- Example for a specific filetype.
                    -- If a pattern is missing, *open a PR* so everyone can benefit.
                    --   rust = {
                    --       'impl_item',
                    --   },
                },
                exact_patterns = {
                    -- Example for a specific filetype with Lua patterns
                    -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
                    -- exactly match "impl_item" only)
                    -- rust = true,
                },
                -- [!] The options below are exposed but shouldn't require your attention,
                --     you can safely ignore them.

                zindex = 20,     -- The Z-index of the context window
                mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
            })
        end,
    },
    "nvim-treesitter/nvim-treesitter-textobjects",
    {
        "zbirenbaum/neodim",
        enabled = IS_KNOWN,
        opts = {
            alpha = 0.5, -- make the dimmed text even dimmer
            blend_color = "#282828",
            hide = {
                -- virtual_text = false,
                -- signs = false,
                -- underline = false,
            },
        },
    },
    {
        "danymat/neogen",
        dependencies = "nvim-treesitter/nvim-treesitter",
        opts = {
            snippet_engine = "luasnip",
            languages = {
                python = {
                    template = {
                        annotation_convention = "numpydoc",
                    },
                },
            },
        },
        keys = {
            {
                "gp",
                ":lua require('neogen').generate()<CR>",
                desc = "Neogen: [G]enerate docstring",
                { noremap = true, silent = true },
            },
        },
        -- Uncomment next line if you want to follow only stable versions
        -- tag = "*"
    },
    {
        "ThePrimeagen/refactoring.nvim",
        enabled = false,
        cond = IS_KNOWN,
        config = function()
            require("refactoring").setup({
                prompt_func_return_type = {
                    go = false,
                    java = false,
                    cpp = false,
                    c = false,
                    h = false,
                    hpp = false,
                    cxx = false,
                },
                prompt_func_param_type = {
                    go = false,
                    java = false,
                    cpp = false,
                    c = false,
                    h = false,
                    hpp = false,
                    cxx = false,
                },
                printf_statements = {},
                print_var_statements = {},
            })

            -- load refactoring Telescope extension
            require("telescope").load_extension("refactoring")

            -- remap to open the Telescope refactoring menu in visual mode
            vim.api.nvim_set_keymap(
                "v",
                "<leader>fa",
                "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
                { noremap = true }
            )
        end,
    },
    {
        "ziontee113/syntax-tree-surfer",
        enabled = IS_KNOWN,
        config = function()
            require("syntax-tree-surfer").setup()
            vim.keymap.set("n", "]s", function()
                vim.opt.opfunc = "v:lua.STSSwapCurrentNodeNextNormal_Dot"
                return "g@l"
            end, { silent = true, expr = true, desc = "Right sibling [s]wap" })

            vim.keymap.set("n", "[s", function()
                vim.opt.opfunc = "v:lua.STSSwapCurrentNodePrevNormal_Dot"
                return "g@l"
            end, { silent = true, expr = true, desc = "Left sibling [s]wap" })
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        config = true,
    },
}
