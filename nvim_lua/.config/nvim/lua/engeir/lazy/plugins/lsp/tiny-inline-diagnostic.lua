return {
  "rachartier/tiny-inline-diagnostic.nvim",
  priority = 1000, -- Needs to be loaded in first
  config = function()
    vim.diagnostic.config({ virtual_text = false })
    require("tiny-inline-diagnostic").setup()
  end,
}
