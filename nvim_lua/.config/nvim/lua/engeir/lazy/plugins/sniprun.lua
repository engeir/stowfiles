return {
  "michaelb/sniprun",
  branch = "master",

  build = "sh install.sh",
  -- do 'sh install.sh 1' if you want to force compile locally
  -- (instead of fetching a binary from the github release). Requires Rust >= 1.65

  config = function()
    -- See https://michaelb.github.io/sniprun/sources/README.html#configuration
    require("sniprun").setup({
      interpreter_options = {
        Python3_original = {
          interpreter = "mise x -- python",
          venv = { ".venv" },
        },
      },
      display = {
        "TempFloatingWindow",
        "VirtualTextOk",
      },
    })
  end,
  keys = {
    { "<leader>tb", "<cmd>SnipRun<CR>", desc = "Run code with Sniprun" },
  },
}
