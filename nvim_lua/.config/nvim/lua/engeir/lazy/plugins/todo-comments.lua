return {
  "folke/todo-comments.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    keywords = {
      FIXME = {
        icon = " ",
        color = "error", -- can be a hex color, or a named color (see below)
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
      },
      TODO = { icon = " ", color = "#5888ef" }, -- 'info' is too dark
      HACK = { icon = " ", color = "warning" },
      WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
      PERF = {
        icon = " ",
        color = "#ff9f00",
        alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" },
      },
      NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
      URGE = { icon = "‼ ", color = "#c9ff19", alt = { "IMPORTANT" } },
    },
  },
  keys = {
    { "<leader>wtq", "<cmd>TodoQuickFix<CR>", desc = "TodoQuickFix" },
  },
}
