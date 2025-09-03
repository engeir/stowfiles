return {
  {
    "nvim-telescope/telescope.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "nvim-telescope/telescope-bibtex.nvim",
        event = { "BufReadPre", "BufNewFile" },
      },
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-tree/nvim-web-devicons",
      "nvim-mini/mini.fuzzy",
    },
    config = function()
      -- Don't preview binaries
      -- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#dont-preview-binaries
      local previewers = require("telescope.previewers")
      local Job = require("plenary.job")
      local new_maker = function(filepath, bufnr, opts)
        filepath = vim.fn.expand(filepath)
        Job
          :new({
            command = "file",
            args = { "--mime-type", "-b", filepath },
            on_exit = function(j)
              local mime_type = vim.split(j:result()[1], "/")[1]
              if mime_type == "text" then
                previewers.buffer_previewer_maker(filepath, bufnr, opts)
              else
                -- maybe we want to write something to the buffer here
                vim.schedule(
                  function()
                    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
                  end
                )
              end
            end,
          })
          :sync()
      end

      local actions = require("telescope.actions")
      local trouble = require("trouble.sources.telescope")
      local telescope = require("telescope")
      local state = require("telescope.state")
      local action_state = require("telescope.actions.state")
      -- local bibtex_actions = require("telescope-bibtex.actions")
      -- https://github.com/nvim-telescope/telescope.nvim/issues/1048#issuecomment-1679797700
      local select_one_or_multi = function(prompt_bufnr)
        local picker =
          require("telescope.actions.state").get_current_picker(prompt_bufnr)
        local multi = picker:get_multi_selection()
        if not vim.tbl_isempty(multi) then
          require("telescope.actions").close(prompt_bufnr)
          for _, j in pairs(multi) do
            if j.path ~= nil then vim.cmd(string.format("%s %s", "edit", j.path)) end
          end
        else
          require("telescope.actions").select_default(prompt_bufnr)
        end
      end

      -- https://github.com/nvim-telescope/telescope.nvim/issues/2602#issuecomment-1636809235
      local slow_scroll = function(prompt_bufnr, direction)
        local previewer = action_state.get_current_picker(prompt_bufnr).previewer
        local status = state.get_status(prompt_bufnr)

        -- Check if we actually have a previewer and a preview window
        if
          type(previewer) ~= "table"
          or previewer.scroll_fn == nil
          or status.preview_win == nil
        then
          return
        end

        previewer:scroll_fn(1 * direction)
      end
      telescope.setup({
        defaults = {
          layout_strategy = "vertical",
          generic_sorter = require("mini.fuzzy").get_telescope_sorter,
          file_sorter = require("mini.fuzzy").get_telescope_sorter,
          mappings = {
            i = {
              ["<esc>"] = actions.close,
              ["<cr>"] = select_one_or_multi,
              ["<C-j>"] = function(bufnr) slow_scroll(bufnr, 1) end,
              ["<C-k>"] = function(bufnr) slow_scroll(bufnr, -1) end,
              ["<C-f>"] = actions.results_scrolling_up,
              ["<C-b>"] = actions.results_scrolling_down,
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<c-t>"] = trouble.open,
              -- Bibtex
              -- CR, C-c and C-e are already mapped
              -- <C-m>_ is a mark for the given format
              -- <C-r>_ is a reference for the given format
              -- ["<C-m>h"] = bibtex_actions.key_append([[^@%s]]),
              -- ["<C-r>h"] = bibtex_actions.citation_append(
              --   "[^@{{label}}]: {{author}}, '{{title}}', {{journal}}, {{year}}, vol. {{volume}}, no. {{number}}, p. {{pages}}."
              -- ),
              -- ["<C-m>r"] = bibtex_actions.citation_append(
              --   '<a href="https://doi.org/{{doi}}" data-citation-key="@{{label}}">{{author}} ({{year}})</a>'
              -- ),
              -- ["<C-r>r"] = bibtex_actions.citation_append(
              --   '<div class="csl-entry" id="ref-{{label}}" role="doc-biblioentry"> {{author}}, {{title}}, {{journal}}, {{year}}, vol. {{volume}}, no. {{number}}, p. {{pages}}.</div>'
              -- ),
            },
            n = { ["<c-t>"] = trouble.open },
          },
          buffer_previewer_maker = new_maker,
          path_display = {
            filename_first = { reverse_dirs = true },
            shorten = 4,
          },
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--hidden",
            "--smart-case",
            "--trim",
          },
        },
        pickers = {
          colorscheme = {
            enable_preview = true,
          },
          grep_string = {
            layout_strategy = "vertical",
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({
              -- more options
            }),
          },
          bibtex = {
            -- Path to global bibliographies (placed outside of the project)
            global_files = { "/home/een023/science/ref/ref.bib" },
            -- Context awareness disabled by default
            context = true,
            -- Fallback to global/directory .bib files if context not found
            -- This setting has no effect if context = false
            context_fallback = true,
          },
          smart_open = {
            match_algorithm = "fzf",
            disable_devicons = false,
          },
        },
      })

      telescope.load_extension("fzf")
    end,
    keys = {
      -- {
      --   "<leader>fc",
      --   function() require("telescope.builtin").commands() end,
      --   desc = "Find Commands",
      -- },
      {
        "<leader>fd",
        function() require("telescope.builtin").diagnostics() end,
        desc = "Find Diagnostics",
      },
      -- {
      --   "<leader>ff",
      --   function()
      --     require("telescope.builtin").find_files({ hidden = true })
      --   end,
      --   desc = "Find Files",
      -- },
      {
        "<leader>fh",
        function() require("telescope.builtin").help_tags() end,
        desc = "Find Help tags",
      },
      {
        "<leader>fk",
        function() require("telescope.builtin").keymaps() end,
        desc = "Find Keymaps",
      },
      {
        "<leader>fl",
        function() require("telescope.builtin").current_buffer_fuzzy_find() end,
        desc = "Find Lines",
      },
      {
        "<leader>fo",
        function() require("telescope.builtin").git_commits() end,
        desc = "Find Commits",
      },
      {
        "<leader>fp",
        function() require("telescope.builtin").spell_suggest() end,
        desc = "Find Spell suggestions",
      },
      -- {
      --   "<leader>fr",
      --   function() require("telescope.builtin").grep_string({ search = "" }) end,
      --   desc = "Find Ripgrep (find string)",
      -- },
      {
        "<leader>fs",
        function() require("telescope.builtin").git_files({ cwd = "~/stowfiles/" }) end,
        desc = "Find Stowfiles",
      },
      {
        "<leader>fw",
        function() require("telescope.builtin").grep_string() end,
        desc = "Find Word under cursor",
      },
    },
  },
  {
    "danielfalk/smart-open.nvim",
    event = { "BufReadPre", "BufNewFile" },
    branch = "0.2.x",
    config = function() require("telescope").load_extension("smart_open") end,
    dependencies = {
      "kkharji/sqlite.lua",
      -- Only required if using match_algorithm fzf
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      -- Optional.  If installed, native fzy will be used when match_algorithm is fzy
      -- { "nvim-telescope/telescope-fzy-native.nvim" },
    },
    keys = {
      -- {
      --   "<leader>fg",
      --   function() require("telescope").extensions.smart_open.smart_open() end,
      --   desc = "Find Files",
      --   noremap = true,
      --   silent = true,
      -- },
    },
  },
  {
    "nvim-telescope/telescope-bibtex.nvim",
    event = { "BufReadPre", "BufNewFile" },
    enabled = false, -- I'm just using either vimtex or texlab to complete this now.
    config = function() require("telescope").load_extension("bibtex") end,
    ft = "tex",
    keys = {
      { "<leader>fb", "<cmd>Telescope bibtex<cr>", desc = "Find Bibtex" },
    },
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    event = "InsertEnter",
    config = function() require("telescope").load_extension("ui-select") end,
  },
}
