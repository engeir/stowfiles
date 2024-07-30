return {
  "linrongbin16/fzfx.nvim",
  dependencies = {
    {
      "echasnovski/mini.icons",
      config = function()
        require("mini.icons").setup()
        MiniIcons.mock_nvim_web_devicons()
      end,
    },
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
