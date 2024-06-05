return {
  "chrisgrieser/nvim-rulebook",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    {
      "<leader>i",
      function()
        require("rulebook").ignoreRule()
      end,
      desc = "Rulebook [I]gnore",
    },
    {
      "<leader>l",
      function()
        require("rulebook").lookupRule()
      end,
      desc = "Rulebook [L]ookup",
    },
  },
}
