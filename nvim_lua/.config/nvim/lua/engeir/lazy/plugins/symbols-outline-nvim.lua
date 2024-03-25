return {
  "simrat39/symbols-outline.nvim",
  enabled = IS_KNOWN,
  opts = {
    auto_close = false,
    width = 40,
    keymaps = { -- These keymaps can be a string or a table for multiple keys
      close = { "<Esc>", "q" },
      goto_location = "o",
      focus_location = "<Cr>",
    },
  },
  keys = {
    {
      "<leader>do",
      "<cmd>SymbolsOutline<cr> ",
      desc = "SymbolsOutline Toggle, [D]ocument [O]outline",
    },
  },
}
