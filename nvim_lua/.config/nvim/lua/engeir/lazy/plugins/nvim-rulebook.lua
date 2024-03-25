return {
  "chrisgrieser/nvim-rulebook",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    {
      "<leader>i",
      function()
        require("rulebook").ignoreRule()
      end,
    },
    {
      "<leader>l",
      function()
        require("rulebook").lookupRule()
      end,
    },
  },
}
