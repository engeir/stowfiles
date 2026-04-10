local languages = {
  "bash",
  "bibtex",
  "css",
  "git_config",
  -- "gitcommit",
  "gitignore",
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
}
return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local ts = require("nvim-treesitter")

      ts.install(languages)

      -- Not every tree-sitter parser is the same as the file type detected So the
      -- patterns need to be registered more cleverly
      local patterns = {}
      for _, parser in ipairs(languages) do
        local parser_patterns = vim.treesitter.language.get_filetypes(parser)
        for _, pp in pairs(parser_patterns) do
          table.insert(patterns, pp)
        end
      end

      -- Example showing how to add custom patterns, see
      -- https://github.com/nvim-treesitter/nvim-treesitter#adding-custom-languages
      -- `vim.treesitter.language.register("groovy", "Jenkinsfile")`

      vim.treesitter.query.add_predicate("is-mise?", function(_, _, bufnr, _)
        local fname = vim.api.nvim_buf_get_name(tonumber(bufnr) or 0)
        return fname:match("mise%.toml$") ~= nil
          or fname:match("%.mise%.toml$") ~= nil
          or fname:match("/mise/config%.toml$") ~= nil
      end, { force = true })

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter.setup", {}),
        callback = function(args)
          local buf = args.buf
          local filetype = args.match

          -- you need some mechanism to avoid running on buffers that do not
          -- correspond to a language (like oil.nvim buffers), this implementation
          -- checks if a parser exists for the current language
          local language = vim.treesitter.language.get_lang(filetype) or filetype
          if not vim.treesitter.language.add(language) then return end

          -- replicate `highlight = { enable = true }`
          vim.treesitter.start(buf, language)

          -- replicate `indent = { enable = true }`
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })

      vim.keymap.set(
        { "x" },
        "[n",
        function() require("vim.treesitter._select").select_prev(vim.v.count1) end,
        { desc = "Select previous treesitter node" }
      )

      vim.keymap.set(
        { "x" },
        "]n",
        function() require("vim.treesitter._select").select_next(vim.v.count1) end,
        { desc = "Select next treesitter node" }
      )

      vim.keymap.set({ "x", "o", "n" }, "<c-n>", function()
        if vim.treesitter.get_parser(nil, nil, { error = false }) then
          require("vim.treesitter._select").select_parent(vim.v.count1)
        else
          vim.lsp.buf.selection_range(vim.v.count1)
        end
      end, {
        desc = "Select parent treesitter node or outer incremental lsp selections",
      })

      vim.keymap.set({ "x", "o", "n" }, "<c-m>", function()
        if vim.treesitter.get_parser(nil, nil, { error = false }) then
          require("vim.treesitter._select").select_child(vim.v.count1)
        else
          vim.lsp.buf.selection_range(-vim.v.count1)
        end
      end, {
        desc = "Select child treesitter node or inner incremental lsp selections",
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
      max_lines = 0,
      trim_scope = "outer",
      patterns = {
        default = {
          "class",
          "function",
          "method",
        },
      },
      zindex = 20,
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
