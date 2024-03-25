return {
  "linrongbin16/fzfx.nvim",
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
    {
      "junegunn/fzf",
      build = function()
        vim.fn["fzf#install"]()
      end,
    },
  },
  cmd = { "FzfxGBlame", "FzfxGCommits" },

  -- specify version to avoid break changes
  version = "v5.*",

  config = function()
    require("fzfx").setup()
  end,
}
