return {
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter" },
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-buffer", event = { "BufReadPost" } },
      { "hrsh7th/cmp-path", event = { "BufReadPost" } },
      { "hrsh7th/cmp-cmdline", event = { "BufReadPre", "BufNewFile" } },
      { "L3MON4D3/LuaSnip", event = { "BufReadPre", "BufNewFile" } },
      { "saadparwaiz1/cmp_luasnip", event = { "BufReadPost" } },
      { "hrsh7th/cmp-nvim-lua", event = { "BufReadPost" } },
      { "hrsh7th/cmp-calc", event = { "BufReadPost" } },
      { "zbirenbaum/copilot-cmp", event = { "InsertEnter" } },
      -- Icons for the LSP cmp view
      { "onsails/lspkind.nvim", event = { "BufReadPost" } },
      -- Latex supersupport
      { "micangl/cmp-vimtex", event = { "BufReadPost" } },
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")
      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0
          and vim.api
              .nvim_buf_get_lines(0, line - 1, line, true)[1]
              :sub(col, col)
              :match("%s")
            == nil
      end

      -- default sources for all buffers
      -- sources = {
      --     { name = "calc" },
      --     { name = "gh_issues" },
      --     { name = "nvim_lsp" },
      --     { name = "path" },
      --     { name = "buffer", keyword_length = 4 },
      --     { name = "nvim_lua" },
      --     { name = "luasnip" }, -- For luasnip users.
      --     { name = "codeium" },
      --     -- { name = "orgmode" },
      --     -- { name = "cmp_tabnine" },
      -- },
      local bufIsBig = function(bufnr)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
        if ok and stats and stats.size > max_filesize then
          return true
        else
          return false
        end
      end
      local default_cmp_sources = cmp.config.sources({
        { name = "lazydev", group_index = 0 }, -- set group index to 0 to skip loading LuaLS completions
        { name = "gh_issues" },
        { name = "calc" },
        { name = "path" },
        { name = "buffer", keyword_length = 4 },
        { name = "copilot" },
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "nvim_lua" },
        { name = "luasnip" },
      }, {
        { name = "codeium" },
        { name = "vimtex" },
      })
      -- If a file is too large, I don't want to add to it's cmp sources treesitter, see:
      -- https://github.com/hrsh7th/nvim-cmp/issues/1522
      vim.api.nvim_create_autocmd("BufReadPre", {
        callback = function(t)
          local sources = default_cmp_sources
          if not bufIsBig(t.buf) then
            sources[#sources + 1] = { name = "treesitter", group_index = 2 }
          end
          cmp.setup.buffer({
            sources = sources,
          })
        end,
      })
      local opts = {
        completion = {
          completeopt = "menu,menuone,preview,noselect",
        },
        -- From TJ
        -- https://github.com/tjdevries/config_manager/blob/78608334a7803a0de1a08a9a4bd1b03ad2a5eb11/xdg_config/nvim/after/plugin/completion.lua#L129
        sorting = {
          -- TODO: Would be cool to add stuff like "See variable names before method
          -- names" in rust, or something like that.
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,

            -- copied from cmp-under, but I don't think I need the plugin for this. I
            -- might add some more of my own.
            function(entry1, entry2)
              local _, entry1_under = entry1.completion_item.label:find("^_+")
              local _, entry2_under = entry2.completion_item.label:find("^_+")
              entry1_under = entry1_under or 0
              entry2_under = entry2_under or 0
              if entry1_under > entry2_under then
                return false
              elseif entry1_under < entry2_under then
                return true
              end
            end,

            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        formatting = {
          -- Youtube: How to set up nice formatting for your sources.
          format = lspkind.cmp_format({
            -- with_text = true,
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
            symbol_map = {
              Copilot = "",
              Codeium = "",
            },
            menu = {
              buffer = "[buf]",
              nvim_lsp = "[LSP]",
              nvim_lua = "[api]",
              path = "[path]",
              luasnip = "[snip]",
              gh_issues = "[issues]",
              tn = "[TabNine]",
              eruby = "[erb]",
              codeium = "[ai]",
              copilot = "[ai]",
              -- vimtex = vim_item.menu,
              vimtex = "[Vimtex]",
            },
          }),
        },
        -- :h ins-completion
        mapping = cmp.mapping.preset.insert({
          ["<C-f>"] = cmp.mapping.scroll_docs(4), -- Forward
          ["<C-b>"] = cmp.mapping.scroll_docs(-4), -- Backward
          -- ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-p>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          -- ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-n>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-Space>"] = cmp.mapping.complete(),
          -- ["<C-l>"] = cmp.mapping(function()
          --     if luasnip.expand_or_locally_jumpable() then
          --         luasnip.expand_or_jump()
          --     end
          -- end, { "i", "s" }),
          -- ["<C-h>"] = cmp.mapping(function()
          --     if luasnip.locally_jumpable(-1) then
          --         luasnip.jump(-1)
          --     end
          -- end, { "i", "s" }),
        }),
        sources = default_cmp_sources,
        -- {
        --     { name = "calc" },
        --     { name = "gh_issues" },
        --     { name = "nvim_lsp" },
        --     { name = "path" },
        --     { name = "buffer", keyword_length = 4 },
        --     { name = "nvim_lua" },
        --     { name = "luasnip" }, -- For luasnip users.
        --     { name = "codeium" },
        --     -- { name = "orgmode" },
        --     -- { name = "cmp_tabnine" },
        -- },
        view = {
          entries = "native_menu",
        },
        experimental = {
          ghost_text = true,
        },
      }
      vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
      cmp.setup(opts)
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            },
          },
        }),
      })
      if vim.fn.executable("gh") then
        require("engeir.lazy.plugins.lsp.cmp-sources.cmp_gh_source")
      end
    end,
  },

  -- Snippets
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "engeir/luasnip-latex-snippets.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    build = "make install_jsregexp",
    -- dependencies = "rafamadriz/friendly-snippets",
    -- dependencies = "iurimateus/luasnip-latex-snippets.nvim",
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
              virt_text = { { "<-", "Error" } },
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
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
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
