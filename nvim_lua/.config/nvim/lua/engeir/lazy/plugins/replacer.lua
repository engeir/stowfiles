local opts = { save_on_write = true, rename_files = true }
return {
  "gabrielpoca/replacer.nvim",
  opts = { rename_files = true },
  keys = {
    {
      "crs",
      function()
        require("replacer").save(opts)
      end,
      desc = "[r]eplacer.nvim [S]ave",
    },
    {
      "cre",
      function()
        require("replacer").run(opts)
      end,
      desc = "[r]eplacer.nvim [E]dit",
    },
  },
}
