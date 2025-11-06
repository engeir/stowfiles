---@module "lazy"
---@type LazySpec
return {
  {
    "saghen/blink.cmp",
    lazy = false, -- lazy loading handled internally
    dependencies = {
      "rafamadriz/friendly-snippets",
      "folke/lazydev.nvim",
      {
        "saghen/blink.compat",
        dependencies = {
          "micangl/cmp-vimtex",
          "hrsh7th/cmp-calc",
        },
        version = "*",
        lazy = true,
        opts = {},
      },
    },
    version = "*", -- use a release tag to download pre-built binaries

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = "mono",
      },
      cmdline = {
        keymap = {
          preset = "inherit",
          ["<Tab>"] = {
            function(cmp)
              if cmp.is_ghost_text_visible() and not cmp.is_menu_visible() then
                return cmp.accept()
              end
            end,
            "show_and_insert",
            "select_next",
          },
          ["<S-Tab>"] = { "show_and_insert", "select_prev" },
          ["<CR>"] = { "fallback" },
          ["<C-space>"] = { "accept", "fallback" },
          -- disable a keymap from the preset
          ["<C-e>"] = {},
          ["<C-y>"] = {},
        },
        completion = {
          menu = { auto_show = true },
        },
      },
      completion = {
        accept = { auto_brackets = { enabled = true } },
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
        menu = {
          draw = {
            treesitter = { "lsp" },
            columns = {
              { "label", "label_description", gap = 1 },
              { "kind_icon", "kind" },
            },
          },
        },
      },
      keymap = {
        -- https://cmp.saghen.dev/configuration/keymap.html#default
        preset = "default",
        ["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
        ["<C-k>"] = { "snippet_forward", "fallback" },
        ["<C-j>"] = { "snippet_backward", "fallback" },
        ["<C-y>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-space>"] = { "select_and_accept" },
        ["<Tab>"] = {},
        ["<S-Tab>"] = {},
      },
      signature = { enabled = true },
      sources = {
        default = {
          "calc",
          "lazydev",
          "lsp",
          "path",
          "snippets",
          "buffer",
          "vimtex",
        },
        per_filetype = {
          codecompanion = { "codecompanion" },
        },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
          vimtex = {
            name = "vimtex",
            module = "blink.compat.source",
            score_offset = 10,
            opts = {},
          },
          calc = {
            name = "calc",
            module = "blink.compat.source",
            score_offset = 20,
            opts = {},
          },
        },
      },
    },
    opts_extend = { "sources.default" },
  },
}
