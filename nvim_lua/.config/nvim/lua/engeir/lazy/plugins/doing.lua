return {
  "Hashino/doing.nvim",
  ---@module 'doing.nvim'
  ---@type DoingOptions
  opts = {
    winbar = { enabled = true },
    store = {
      -- file_name = vim.fn.expand("~") .. "/.local/share/nvim/doing.nvim/tasks",
      sync_tasks = true,
    },
  },
  lazy = false, -- TODO: A PR allowing this to be removed/true is probably due today
  cmd = { "Do", "Done" },
  keys = {
    {
      "<leader>wta",
      function()
        require("doing").add()
      end,
      desc = "Doing: Add",
    },
    {
      "<leader>wtn",
      function()
        require("doing").done()
      end,
      desc = "Doing: Done",
    },
    {
      "<leader>wte",
      function()
        require("doing").edit()
      end,
      desc = "Doing: Edit",
    },
    {
      "<leader>wts",
      function()
        vim.notify(
          require("doing").status(true),
          vim.log.levels.INFO,
          { title = "Doing:", icon = "" }
        )
      end,
      desc = "Doing: Status",
    },
  },
}
