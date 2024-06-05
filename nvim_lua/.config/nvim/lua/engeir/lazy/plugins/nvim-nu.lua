return {
  "LhKipp/nvim-nu",
  build = ":TSInstall nu",
  event = { "BufReadPre", "BufNewFile" },
  ft = { "nu" },
}
