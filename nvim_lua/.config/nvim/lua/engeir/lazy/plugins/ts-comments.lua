return {
  "folke/ts-comments.nvim",
  opts = { lang = { kdl = "# %s", nu = "# %s", jsonc = "// %s" } },
  event = { "BufReadPre", "BufNewFile" },
  enabled = vim.fn.has("nvim-0.10.0") == 1,
}
