return {
  "stevearc/dressing.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    input = { insert_only = false },
  },
}
