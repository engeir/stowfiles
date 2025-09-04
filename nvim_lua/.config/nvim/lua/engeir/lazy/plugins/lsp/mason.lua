return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = {
    {
      "mason-org/mason-lspconfig.nvim",
      opts = {},
      dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
      },
    },
  },
  opts = {
    auto_update = true,
    ensure_installed = {
      "bash-language-server",
      "beautysh",
      "html-lsp",
      "json-lsp",
      "jsonlint",
      "lua_ls",
      "markdownlint",
      "mypy",
      "pyrefly",
      "ruff",
      "shellcheck",
      "shellharden",
      "sourcery",
      "stylua",
      "taplo",
      "texlab",
      "tinymist",
      "yaml-language-server",
      -- "harper-ls",
      -- "yamlfmt",
    },
    -- integrations = {
    --   ["mason-lspconfig"] = true,
    --   ["mason-null-ls"] = false,
    --   ["mason-nvim-dap"] = false,
    -- },
  },
}
