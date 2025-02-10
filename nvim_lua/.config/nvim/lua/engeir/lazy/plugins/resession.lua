return {
  "stevearc/resession.nvim",
  keys = {
    {
      "<leader>sw",
      function() require("resession").save() end,
      desc = "Session: Write",
    },
    {
      "<leader>sr",
      function() require("resession").load() end,
      desc = "Session: Read",
    },
    {
      "<leader>sd",
      function() require("resession").delete() end,
      desc = "Session: Delete",
    },
  },
  opts = {
    autosave = {
      enabled = true,
      interval = 60,
      notify = false,
    },
  },
}
