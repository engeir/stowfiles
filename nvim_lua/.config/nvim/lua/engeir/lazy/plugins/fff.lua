return {
  "dmtrKovalenko/fff.nvim",
  build = function() require("fff.download").download_or_build_binary() end,
  lazy = false,
  keys = {
    {
      "<leader>fg",
      function() require("fff").find_files() end,
      desc = "Find Files",
    },
    {
      "<leader>fp",
      function() require('fff').live_grep() end,
      desc = "Find Grep",
    },
  },
}
