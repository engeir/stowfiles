local ok, impatient = pcall(require, "impatient")
if ok then
  require("impatient")
end
require("tj.globals")

-- General stuff
require("engeir.autocommands")
require("engeir.customcommands")
require("engeir.keymaps")
require("engeir.settings")

-- Automatically install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
    return
end

lazy.setup("plugins")

require("engeir")
