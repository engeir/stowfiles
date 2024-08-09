return {
  "folke/ts-comments.nvim",
  opts = {
    lang = {
      typ = "// %s",
      typst = "// %s",
      kdl = "# %s",
      nu = "# %s",
      jsonc = "// %s",
    },
  },
  event = { "BufReadPre", "BufNewFile" },
  enabled = vim.fn.has("nvim-0.10.0") == 1,
}
