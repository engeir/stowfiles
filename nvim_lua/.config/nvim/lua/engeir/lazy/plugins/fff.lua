return {
  "dmtrKovalenko/fff.nvim",
  build = function() require("fff.download").download_or_build_binary() end,
  lazy = false,
  keys = {
    {
      "<leader>ff",
      function() require("fff").find_files() end,
      desc = "Find Files",
    },
    {
      "<leader>fg",
      function() require("fff").find_in_git_root() end,
      desc = "Find Git Files",
    },
  },
}
