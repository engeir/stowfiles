return {
  "rcarriga/nvim-notify",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("notify").setup({
      background_colour = "#282828",
    })
  end,
}
