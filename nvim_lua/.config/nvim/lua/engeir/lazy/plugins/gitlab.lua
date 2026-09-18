return {
  "harrisoncramer/gitlab.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "dlyongemallo/diffview-plus.nvim",
    "stevearc/dressing.nvim",
  },
  ---@type GitlabSettings
  opts = { config_path = vim.fn.expand("~") .. "/.config/glab-cli/" },
}
