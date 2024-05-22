-- https://github.com/elbkind/nvim/blob/main/lua/plugins/oil.lua
local default_coloumns = function(detailed)
  return detailed
      and {
        { "permissions", highlight = "String" },
        { "mtime", highlight = "Comment" },
        { "size", highlight = "Type" },
        "icon",
      }
    or { "icon" }
end

return {
  -- IMPORTANT: do not Lazy load this, since I want this to be default when opening
  -- vim in a directory.
  "stevearc/oil.nvim",
  keys = {
    {
      "<leader>po",
      function()
        require("oil").open()
      end,
      "[P]ath explorer with [O]il",
    },
  },
  opts = function(_, o)
    o.view_options = {
      -- Show files and directories that start with "."
      show_hidden = true,
      -- This function defines what is considered a "hidden" file
      is_hidden_file = function(name, _)
        return vim.startswith(name, ".")
      end,
      -- This function defines what will never be shown, even when `show_hidden` is set
      is_always_hidden = function(name, _)
        return vim.startswith(name, ".git/")
      end,
    }
    o.float = {
      max_width = 150,
      max_height = 50,
      padding = 5,
    }
    o.keymaps = {
      ["H"] = "actions.parent",
      ["J"] = { callback = "j", desc = "Navigate down" },
      ["K"] = { callback = "k", desc = "Navigate up" },
      ["L"] = "actions.select",
      ["gd"] = {
        desc = "Toggle detail view",
        callback = function()
          local oil = require("oil")
          local config = require("oil.config")
          if #config.columns == #default_coloumns(false) then
            oil.set_columns(default_coloumns(true))
          else
            oil.set_columns(default_coloumns(false))
          end
        end,
      },
    }
  end,
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
