return {
  {
    "saghen/blink.cmp",
    lazy = false, -- lazy loading handled internally
    dependencies = {
      "rafamadriz/friendly-snippets",
      { "L3MON4D3/LuaSnip", version = "v2.*" },
    },
    version = "v0.*", -- use a release tag to download pre-built binaries

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "default",
        cmdline = {
          preset = "enter",
          ["<S-Tab>"] = { "select_prev", "fallback" },
          ["<Tab>"] = { "select_next", "fallback" },
          ["<CR>"] = { "fallback" },
          ["<C-y>"] = { "accept", "fallback" },
          -- disable a keymap from the preset
          ["<C-e>"] = {},
          ["<C-space>"] = {},
        },
      },
      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = "mono",
      },
      completion = {
        accept = { auto_brackets = { enabled = true } },
        documentation = { auto_show = true },
      },
      signature = { enabled = true },
      snippets = { preset = "luasnip" },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
    },
    opts_extend = { "sources.default" },
  },
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
