pcall(require, "impatient")
require("tj.globals")

-- General stuff
require("engeir.autocommands")
require("engeir.customcommands")
require("engeir.keymaps")
require("engeir.settings")
require("custom.python-settings")

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
  { import = "custom.aerial" },
  { import = "custom.alpha" },
  { import = "custom.auto-hlsearch" },
  { import = "custom.autolist" },
  { import = "custom.boole" },
  { import = "custom.color-line" },
  { import = "custom.colorscheme" },
  { import = "custom.color-picker" },
  { import = "custom.comment-nvim" },
  { import = "custom.fidget" },
  { import = "custom.git" },
  { import = "custom.glow" },
  { import = "custom.grammar-guard-nvim" },
  { import = "custom.harpoon" },
  { import = "custom.image-nvim" },
  { import = "custom.impatient" },
  { import = "custom.jupyter-notebook" },
  { import = "custom.lsp" },
  { import = "custom.mind" },
  { import = "custom.mini" },
  { import = "custom.mini" },
  { import = "custom.neorg" },
  { import = "custom.nvim-femaco" },
  { import = "custom.nvim-tree" },
  { import = "custom.orgmode" },
  { import = "custom.smartyank" },
  { import = "custom.swenv" },
  { import = "custom.telescope" },
  { import = "custom.terminal" },
  { import = "custom.treesitter" },
  { import = "custom.undotree" },
  { import = "custom.vim-angry-reviewer" },
  { import = "custom.vim-be-good" },
  { import = "custom.vim-easy-align" },
  { import = "custom.vim-rooter" },
  { import = "custom.vimtex" },
  { import = "custom.zen-mode" },
})

-- require("engeir")

-- vim: ts=2 sts=2 sw=2 et
