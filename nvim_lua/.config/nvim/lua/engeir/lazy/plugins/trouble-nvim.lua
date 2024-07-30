return {
  "folke/trouble.nvim",
  dependencies = {
    {
      "echasnovski/mini.icons",
      config = function()
        require("mini.icons").setup()
        MiniIcons.mock_nvim_web_devicons()
      end,
    },
  },
  opts = { auto_close = true },
  keys = {
    { "crt", "<cmd>Trouble<cr>", desc = "[T]rouble" },
  },
}
