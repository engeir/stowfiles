return {
  "nvchad/minty",
  lazy = true,
  dependencies = { "nvchad/volt", lazy = true },
  keys = {
    {
      "<leader>uch",
      function()
        require("minty.huefy").open()
      end,
    },
    {
      "<leader>ucs",
      function()
        require("minty.shades").open()
      end,
    },
  },
}
