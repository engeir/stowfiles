local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "engeir.lsp.lsp-installer"
require("engeir.lsp.handlers").setup()
require "engeir.lsp.null-ls"
require "engeir.lsp.lsp-signature"
