return {
  "dkarter/bullets.vim",
  enabled = false,
  ft = {
    "markdown",
    "text",
    "tex",
    "plaintex",
  },
  -- should always be on for these file types, so not having a setup function is not a
  -- big deal
  lazy = false,
  init = function()
    vim.g.bullets_enable_in_empty_buffers = 0
  end,
}
