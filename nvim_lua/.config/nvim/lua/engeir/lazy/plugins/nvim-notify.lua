return {
  "rcarriga/nvim-notify",
  event = { "BufReadPre", "BufNewFile" },
  enabled = IS_KNOWN,
  config = function()
    require("notify").setup({
      background_colour = "#282828",
    })
  end,
}
