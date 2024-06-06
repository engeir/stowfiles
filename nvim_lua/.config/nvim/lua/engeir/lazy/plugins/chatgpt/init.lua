return {
  "jackMort/ChatGPT.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    api_key_cmd = "pass ChatGPT/nvim-api-key-project",
    actions_paths = {
      vim.fn.stdpath("config")
        .. "/lua/engeir/lazy/plugins/chatgpt/english-grammar-bot.json",
    },
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
}
