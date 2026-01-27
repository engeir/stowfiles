return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    branch = "master",
    lazy = false,
    priority = 200,
    init = function()
      require("vim.treesitter.query").add_predicate("is-mise?", function(_, _, bufnr, _)
        local filepath = vim.api.nvim_buf_get_name(tonumber(bufnr) or 0)
        local filename = vim.fn.fnamemodify(filepath, ":t")
        return string.match(filename, ".*mise.*%.toml$") ~= nil
      end, { force = true, all = false })
    end,
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "bibtex",
          "css",
          "fortran",
          "go",
          "html",
          "just",
          "lua",
          "markdown",
          "markdown_inline",
          "python",
          "scss",
          "toml",
          "vim",
          "vimdoc",
          -- "latex", -- see vimtex-faq-treesitter for an explanation of why this is difficult with tree-sitter
          -- "norg",
          -- "org",
        },
        sync_install = false,
        auto_install = false,
        ignore_install = {},
        rainbow = {
          enable = false,
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
          disable = { "latex" }, -- see vimtex-faq-treesitter for an explanation of why this is difficult with tree-sitter
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
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      min_window_height = 0,
      line_numbers = true,
      multiline_threshold = 15,
      enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
      max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
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

      zindex = 20, -- The Z-index of the context window
      mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },
}
