-- Terminal Mappings
local function term_nav(dir)
  return function(self)
    return self:is_floating() and "<c-" .. dir .. ">"
      or vim.schedule(function()
        vim.cmd.wincmd(dir)
      end)
  end
end
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    notifier = { enabled = false },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
  keys = {
    {
      "crf",
      function()
        Snacks.rename.rename_file()
      end,
      desc = "Rename File",
    },
  },
}
