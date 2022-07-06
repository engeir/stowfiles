local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

local servers = {
  "bashls",
  "cssls",
  "gopls",
  "html",
  "jsonls",
  "ltex",
  "pyright",
  "rust_analyzer",
  "sumneko_lua",
  "taplo",
  "tsserver",
  "vuels",
  "yamlls",
  -- "texlab",
  -- Need to figure out how to prevent format on save...
}

lsp_installer.setup()

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("engeir.lsp.handlers").on_attach,
    capabilities = require("engeir.lsp.handlers").capabilities,
  }

  if server == "sumneko_lua" then
    local sumneko_opts = require "engeir.lsp.settings.sumneko_lua"
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
  end

  if server == "pyright" then
    local pyright_opts = require "engeir.lsp.settings.pyright"
    opts = vim.tbl_deep_extend("force", pyright_opts, opts)
  end

  lspconfig[server].setup(opts)
end
