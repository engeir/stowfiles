return {
  "stevearc/aerial.nvim",
  dependencies = {
    {
      "echasnovski/mini.icons",
      config = function()
        require("mini.icons").setup()
        MiniIcons.mock_nvim_web_devicons()
      end,
    },
  },
  config = function()
    local air = require("aerial")
    -- local aira = require("aerial.actions")
    air.setup({
      backends = { "treesitter", "lsp", "markdown", "man" },
      layout = {
        max_width = { 100, 0.2 },
        min_width = 40,
      },
      -- Call this function when aerial attaches to a buffer.
      -- Useful for setting keymaps. Takes a single `bufnr` argument.
      on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ap", "<cmd>AerialPrev<CR>", {})
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>an", "<cmd>AerialNext<CR>", {})
        -- -- Jump up the tree with '[[' or ']]'
        -- vim.api.nvim_buf_set_keymap(bufnr, "n", "[[", "<cmd>AerialPrevUp<CR>", {})
        -- vim.api.nvim_buf_set_keymap(bufnr, "n", "]]", "<cmd>AerialNextUp<CR>", {})
      end,
      -- When true, aerial will automatically close after jumping to a symbol
      close_on_select = false,
      -- Show box drawing characters for the tree hierarchy
      show_guides = true,
      -- Options for the floating nav windows
      nav = {
        height = 0.6,
        preview = true,
        keymaps = {
          ["<C-c>"] = "actions.close",
          ["q"] = "actions.close",
          ["o"] = "actions.jump",
          -- ["<CR>"] = { "actions.jump", "actions.close" },
          -- ["<CR>"] = {
          --     callback = function()
          --         air.select()
          --         air.close()
          --     end,
          --     desc = "",
          --     nowait = true,
          -- },
        },
      },
    })
    require("telescope").load_extension("aerial")
  end,
  keys = {
    {
      "<leader>at",
      "<cmd>AerialNavToggle<CR>",
      desc = "Aerial Toggle (list of TS objects)",
    },
  },
}
