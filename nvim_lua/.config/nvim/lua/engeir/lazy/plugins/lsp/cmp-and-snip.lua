return {
  {
    "saghen/blink.cmp",
    lazy = false, -- lazy loading handled internally
    -- optional: provides snippets for the snippet source
    dependencies = "rafamadriz/friendly-snippets",

    -- use a release tag to download pre-built binaries
    version = "v0.*",
    -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- see the "default configuration" section below for full documentation on how to define
      -- your own keymap.
      keymap = { preset = "default" },

      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- will be removed in a future release
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },

      completion = {
        documentation = { auto_show = true },
      },
      -- experimental auto-brackets support
      -- completion = { accept = { auto_brackets = { enabled = true } } }

      -- experimental signature help support
      signature = { enabled = true },
      snippets = {
        expand = function(snippet)
          require("luasnip").lsp_expand(snippet)
        end,
        active = function(filter)
          if filter and filter.direction then
            return require("luasnip").jumpable(filter.direction)
          end
          return require("luasnip").in_snippet()
        end,
        jump = function(direction)
          require("luasnip").jump(direction)
        end,
      },
      sources = {
        default = { "lsp", "path", "luasnip", "buffer" },
      },
    },
    -- allows extending the providers array elsewhere in your config
    -- without having to redefine it
    opts_extend = { "sources.default" },
  },

  -- Snippets
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "engeir/luasnip-latex-snippets.nvim",
      -- "iurimateus/luasnip-latex-snippets.nvim",
    },
    event = { "BufReadPre", "BufNewFile" },
    build = "make install_jsregexp",
    config = function()
      -- See https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua
      -- and teeeej's taketuesday #3 videos for more sweetness
      local ls = require("luasnip")
      local types = require("luasnip.util.types")
      ls.setup({
        history = true,
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = true,
        ext_opts = {
          [types.choiceNode] = {
            active = {
              virt_text = { { "Toggle (<C-l>)", "Error" } },
            },
          },
        },
        snip_env = {
          parse_eval = function(...)
            local snip = ls.parser.parse_snipmate(...)
            table.insert(getfenv(2).ls_file_snippets, snip)
          end,
        },
      })
      vim.keymap.set({ "i", "s" }, "<c-k>", function()
        if ls.jumpable(1) then
          ls.jump(1)
        end
      end, { silent = true })
      -- Jump backward <c-j> (default is just to create a newline)
      vim.keymap.set({ "i", "s" }, "<c-j>", function()
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end, { silent = true })
      -- <c-l> is for selecting within a list of options.
      -- Useful for choice nodes (introduced in the second luasnip tutorial by teeeej)
      vim.keymap.set("i", "<c-l>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end)
      vim.keymap.set("n", "<leader><leader>s", function()
        require("luasnip.loaders").edit_snippet_files()
      end, { desc = "LuaSnip: Source Snippets File" })

      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = { "~/.config/nvim/lua/engeir/lazy/plugins/lsp/luasnippets/vscode/" },
      })
      -- require("luasnip.loaders.from_vscode").lazy_load({
      --     paths = { "~/.config/nvim/lua/engeir/lazy/plugins/lsp/luasnippets/vscode/" },
      --     exclude = { "latex", "tex", "plaintex" },
      -- })
      require("luasnip.loaders.from_lua").load({
        paths = "~/.config/nvim/lua/engeir/lazy/plugins/lsp/luasnippets/lua/",
      })
    end,
  },

  -- Extra
  {
    "engeir/luasnip-latex-snippets.nvim",
    enabled = true,
    event = { "BufReadPre", "BufNewFile" },
    -- replace "lervag/vimtex" with "nvim-treesitter/nvim-treesitter" if you're
    -- using treesitter.
    dependencies = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
    config = function()
      require("luasnip-latex-snippets").setup({
        use_treesitter = false, -- see vimtex-faq-treesitter for an explanation of why this is difficult with tree-sitter
        allow_on_markdown = false,
      })
    end,
    -- treesitter is required for markdown
    ft = { "tex" },
  },
}
