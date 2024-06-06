return {
  "chrisgrieser/nvim-rulebook",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    {
      "cri",
      function()
        require("rulebook").ignoreRule()
      end,
      desc = "Rulebook [I]gnore",
    },
    {
      "crl",
      function()
        require("rulebook").lookupRule()
      end,
      desc = "Rulebook [L]ookup",
    },
  },
}
