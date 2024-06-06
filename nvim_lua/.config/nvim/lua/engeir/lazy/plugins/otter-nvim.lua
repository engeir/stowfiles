return {
  "jmbuhr/otter.nvim",
  enabled = false,
  ft = { "quarto" },
  dependencies = {
    "hrsh7th/nvim-cmp",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("otter").dev_setup()
  end,
}
