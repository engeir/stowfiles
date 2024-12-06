if vim.env.PROF then
  -- example for lazy.nvim
  -- change this to the correct path for your plugin manager
  local snacks = vim.fn.stdpath("data") .. "/lazy/snacks.nvim"
  vim.opt.rtp:append(snacks)
  require("snacks.profiler").startup({
    startup = {
      event = "VimEnter", -- stop profiler on this event. Defaults to `VimEnter`
      -- event = "UIEnter",
      -- event = "VeryLazy",
    },
  })
end
vim.env.PATH = vim.env.HOME .. "/.local/share/mise/shims:" .. vim.env.PATH
require("engeir.basics.globals")

-- General stuff
require("engeir.basics.keymaps")
require("engeir.basics.settings")
require("engeir.basics.python-settings")

-- Plugins
require("engeir.lazy")

-- Commands potentially relying on plugins
require("engeir.basics.autocommands")
require("engeir.basics.customcommands")
-- vim: ts=2 sts=2 sw=2 et
