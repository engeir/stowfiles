return {
  {
    "asiryk/auto-hlsearch.nvim",
    event = "BufReadPost",
    version = "1.0.0",
    config = function()
      require("auto-hlsearch").setup()
    end,
  },
}
