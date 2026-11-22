local is_ubuntu = vim.fn.filereadable("/etc/os-release") == 1
  and vim.fn.system("grep -c 'ID=ubuntu' /etc/os-release"):match("^[1-9]") ~= nil

return {
  "dmtrKovalenko/fff.nvim",
  enabled = not is_ubuntu,
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
      function() require("fff").live_grep() end,
      desc = "Find Grep",
    },
  },
}
