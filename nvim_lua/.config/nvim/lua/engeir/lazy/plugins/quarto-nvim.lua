return {
  "quarto-dev/quarto-nvim",
  enabled = false,
  -- enabled = IS_KNOWN,
  ft = { "quarto" },
  dependencies = {
    { "jpalardy/vim-slime" },
    { "ekickx/clipboard-image.nvim" },
  },
  config = function()
    require("quarto").setup({
      debug = false,
      closePreviewOnExit = true,
      lspFeatures = {
        enabled = true,
        languages = { "r", "python", "julia", "bash" },
        chunks = "curly", -- 'curly' or 'all'
        diagnostics = {
          enabled = true,
          triggers = { "BufWritePost" },
        },
        completion = {
          enabled = true,
        },
      },
      keymap = {
        hover = "K",
        definition = "gd",
        rename = "<leader>rn",
        references = "gr",
      },
    })
  end,
}
