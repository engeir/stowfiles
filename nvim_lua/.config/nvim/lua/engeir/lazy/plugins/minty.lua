return {
  "nvchad/minty",
  lazy = true,
  dependencies = { "nvchad/volt", lazy = true },
  keys = {
    {
      "<leader>uch",
      function() require("minty.huefy").open() end,
      desc = "Color picker, hues",
    },
    {
      "<leader>ucs",
      function() require("minty.shades").open() end,
      desc = "Color picker, shades",
    },
  },
}
