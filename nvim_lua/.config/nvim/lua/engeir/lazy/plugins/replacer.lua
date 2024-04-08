local opts = { save_on_write = true, rename_files = true }
return {
  "gabrielpoca/replacer.nvim",
  opts = { rename_files = true },
  keys = {
    {
      "<leader>rs",
      function()
        require("replacer").save(opts)
      end,
      desc = "[r]eplacer.nvim [S]ave",
    },
    {
      "<leader>rr",
      function()
        require("replacer").run(opts)
      end,
      desc = "[r]eplacer.nvim [R]eplace",
    },
  },
}
