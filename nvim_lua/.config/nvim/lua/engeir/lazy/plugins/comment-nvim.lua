local version
if vim.fn.has("nvim-0.10") == 1 then
  -- We don't need a commenting plugin any more! But maybe we do, since I don't think we
  -- can configure custom comment rules yet.
  version = true -- false
else
  version = true
end

return {
  "numToStr/Comment.nvim",
  dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
  event = { "BufReadPre", "BufNewFile" },
  enabled = version,
  config = function()
    require("Comment").setup({
      pre_hook = function()
        return vim.bo.commentstring
      end,
    })

    local ft = require("Comment.ft")
    ft.set("ncl", ";%s")
      .set("sent", "#%s")
      .set("jsonc", "//%s")
      .set("mplstyle", "#%s")
      .set("nu", "#%s")
      .set("kdl", "#%s")
  end,
}
