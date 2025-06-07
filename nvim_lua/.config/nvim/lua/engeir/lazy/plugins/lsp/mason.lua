return {
  "mason-org/mason.nvim",
  version = "1.*",
  build = ":MasonUpdate",
  dependencies = {
    { "mason-org/mason-lspconfig.nvim", version = "1.*" },
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      opts = {
        auto_update = true,
        ensure_installed = {
          { "bash-language-server", auto_update = true },
          "beautysh",
          "harper-ls",
          "html-lsp",
          "jedi-language-server",
          "json-lsp",
          "jsonlint",
          "lua-language-server",
          "markdownlint",
          "mypy",
          "ruff",
          "shellcheck",
          "shellharden",
          "sourcery",
          "stylua",
          "taplo",
          "texlab",
          "tinymist",
          "yaml-language-server",
          "yamlfmt",
        },
        integrations = {
          ["mason-lspconfig"] = true,
          ["mason-null-ls"] = false,
          ["mason-nvim-dap"] = false,
        },
      },
    },
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
