-- The configuration is found in the lsp folder inside the nvim config folder:
-- ~.config/lsp/*.lua
vim.lsp.enable({
  "harper_ls",
  "jedi_language_server",
  "jsonls",
  "lua_ls",
  "texlab",
  "tinymist",
  "yamlls",
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(_)
    -- `stevearc/conform.nvim` changes the `formatexpr` value, but at least for
    -- `lua`, this fucks up the `gq<mothion>` command, at least on comments. The
    -- empty string sets the default, which hopefully works fine in other languages
    -- as well. Let's see.
    vim.o.formatexpr = ""
  end,
})

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "▲",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "󰈻",
    },
  },
  update_in_insert = true,
  underline = false,
  severity_sort = true,
  float = {
    focusable = true,
    style = "minimal",
    source = "always",
  },
  virtual_lines = false, -- uses tiny-inline-diagnostics
})
