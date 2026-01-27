return {
  "A7Lavinraj/fyler.nvim",
  dependencies = { "nvim-mini/mini.icons" },
  branch = "stable", -- Use stable branch for production
  lazy = false, -- Necessary for `default_explorer` to work properly
  keys = {
    {
      "<leader>pp",
      function() require("fyler").toggle({ kind = "split_right_most" }) end,
      desc = "Fyler",
    },
  },
  opts = {
    views = {
      finder = {
        mappings = {
          ["q"] = "CloseView",
          ["L"] = "Select",
          ["<C-t>"] = "SelectTab",
          ["|"] = "SelectVSplit",
          ["-"] = "SelectSplit",
          ["^"] = "GotoParent",
          ["="] = "GotoCwd",
          ["."] = "GotoNode",
          ["#"] = "CollapseAll",
          ["H"] = "CollapseNode",
        },
      },
    },
  },
}
