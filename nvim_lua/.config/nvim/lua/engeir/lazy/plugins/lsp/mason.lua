return {
  "williamboman/mason.nvim",
  build = ":MasonUpdate",
  cmd = { "Mason" },
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
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
