return {
  "Exafunction/codeium.nvim",
  enabled = IS_KNOWN and IS_LINUX,
  ft = { "py" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  config = true,
}
