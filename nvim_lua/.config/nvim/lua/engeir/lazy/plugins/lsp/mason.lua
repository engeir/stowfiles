return {
  "mason-org/mason.nvim",
  version = "1.*",
  event = { "BufReadPre", "BufNewFile" },
  build = ":MasonUpdate",
  cmd = { "Mason" },
  dependencies = {
    "mason-org/mason-lspconfig.nvim",
    version = "1.*",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconf = require("mason-lspconfig")

    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconf.setup({
      ensure_installed = {},
      automatic_installation = false,
    })
  end,
}
