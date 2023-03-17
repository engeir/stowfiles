local ok, ts = pcall(require, "nvim-treesitter.configs")
if not ok then
    return
end

ts.setup({
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
    indent = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<c-n>",
            node_incremental = "<c-n>",
            scope_incremental = "<c-s>",
            node_decremental = "<c-m>",
        },
    },
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
    rainbow = {
        enable = true,
        -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
        -- colors = {}, -- table of hex strings
        -- termcolors = {} -- table of colour name strings
    },
    textobjects = {
        select = {
            enable = true,
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
            swap_next = {
                ["]n"] = "@parameter.inner",
            },
            swap_previous = {
                ["[n"] = "@parameter.inner",
            },
        },
    },
})
