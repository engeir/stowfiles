local version
if vim.fn.has("nvim-0.10") == 1 then
  -- We don't need a commenting plugin any more!
  version = false
else
  version = true
end

return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  enabled = version,
  config = function()
    require("Comment").setup()

    local ft = require("Comment.ft")
    ft.set("ncl", ";%s")
    ft.set("sent", "#%s")
    ft.set("jsonc", "//%s")
    ft.set("mplstyle", "#%s")
    ft.set("nu", "#%s")
    ft.set("kdl", "#%s")
  end,
}
