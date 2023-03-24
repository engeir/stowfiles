pcall(require, "impatient")
require("engeir.basics.globals")

-- General stuff
require("engeir.basics.autocommands")
require("engeir.basics.customcommands")
require("engeir.basics.keymaps")
require("engeir.basics.settings")
require("engeir.basics.python-settings")

-- Automatically install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",     -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  return
end

lazy.setup({
  { import = "engeir.plugins" },
})

-- vim: ts=2 sts=2 sw=2 et
