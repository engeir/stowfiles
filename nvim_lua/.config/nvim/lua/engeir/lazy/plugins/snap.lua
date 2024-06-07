return {
  {
    "camspiers/luarocks",
    opts = { rocks = { "fzy" } },
  },
  {
    "camspiers/snap",
    keys = function()
      local snap = require("snap")
      return {
        {
          "<Leader>ss",
          snap.config.file({ producer = "ripgrep.file" }),
          desc = "Snap search file (ripgrep)",
        },
        {
          "<Leader>sb",
          snap.config.file({ producer = "vim.buffer" }),
          desc = "Snap search buffers",
        },
        {
          "<Leader>so",
          snap.config.file({ producer = "vim.oldfile" }),
          desc = "Snap search old files",
        },
        { "<Leader>sg", snap.config.vimgrep({}), desc = "Snap search grep in file" },
      }
    end,
    dependencies = { "camspiers/luarocks" },
  },
}
