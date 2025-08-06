return {
  "dmtrKovalenko/fff.nvim",
  build = "cargo +nightly build --release",
  opts = { prompt = "➜ " },
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
