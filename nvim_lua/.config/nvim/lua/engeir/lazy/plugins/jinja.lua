vim.filetype.add({
  extension = {
    ["yaml.j2"] = "yaml.jinja2",
    ["sql.j2"] = "sql.jinja2",
    ["lua.j2"] = "lua.jinja2",
  },
})

return {
  "HiPhish/jinja.vim",
  lazy = false,
  init = function()
    -- optional: turn *.html into html.jinja when Jinja syntax is found
    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      pattern = { "*.html", "*.lua" },
      callback = function() vim.fn["jinja#AdjustFiletype"]() end,
    })
  end,
}
