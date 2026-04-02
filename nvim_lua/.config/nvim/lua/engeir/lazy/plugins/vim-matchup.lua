return {
  enabled = false,
  "andymass/vim-matchup",
  dependencies = "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    treesitter = {
      stopline = 500,
    },
  },
}
