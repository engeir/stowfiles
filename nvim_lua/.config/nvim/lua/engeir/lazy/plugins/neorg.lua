return {
  "nvim-neorg/neorg",
  enabled = false,
  build = ":Neorg sync-parsers",
  ft = "norg",
  cmd = "Neorg",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-cmp",
    "nvim-lua/plenary.nvim",
  },
  opts = {
    load = {
      ["core.defaults"] = {}, -- Loads default behaviour
      ["core.completion"] = { config = { engine = "nvim-cmp", name = "[Norg]" } },
      ["core.concealer"] = { config = { icon_preset = "diamond" } },
      ["core.dirman"] = { -- Manages Neorg workspaces
        config = {
          workspaces = {
            notes = "~/notes",
            todo = "~/projects/todo",
          },
        },
      },
      ["core.integrations.nvim-cmp"] = {},
      ["core.export"] = {},
      ["core.keybinds"] = {
        -- https://github.com/nvim-neorg/neorg/blob/main/lua/neorg/modules/core/keybinds/keybinds.lua
        config = {
          default_keybinds = true,
          neorg_leader = "<Leader><Leader>",
        },
      },
    },
  },
}
