return {
  "johmsalas/text-case.nvim",
  config = function()
    require("textcase").setup({})
    require("telescope").load_extension("textcase")
  end,
  keys = {
    {
      "crc",
      "<cmd>TextCaseOpenTelescope<CR>",
      mode = { "n", "v" },
      desc = "Telescope Text [C]ase [C]hange",
    },
  },
}
