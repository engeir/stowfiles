return {
  "LhKipp/nvim-nu",
  enabled = false,
  build = ":TSInstall nu",
  event = { "BufReadPre", "BufNewFile" },
  ft = { "nu" },
}
