local opts = { save_on_write = false, rename_files = false }
return {
  "gabrielpoca/replacer.nvim",
  opts = { rename_files = false },
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
