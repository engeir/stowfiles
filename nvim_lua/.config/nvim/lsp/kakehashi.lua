return {
  cmd = { "kakehashi" },
  init_options = {
    autoInstall = true,
    languages = {
      markdown = {
        bridge = {
          python = { enabled = true },
          rust = { enabled = true },
          lua = { enabled = true },
          bash = { enabled = true },
        },
      },
    },
    languageServers = {
      ["rust-analyzer"] = {
        cmd = { "rust-analyzer" },
        languages = { "rust" },
        workspaceType = "cargo",
      },
      -- ["zuban"] = {
      --   cmd = { "zuban", "server" },
      --   languages = { "python" },
      -- },
      ["pyrefly"] = {
        cmd = { "pyrefly", "lsp" },
        languages = { "python" },
      },
      -- ["ruff"] = {
      --   cmd = { "ruff", "server" },
      --   languages = { "python" },
      -- },
      ["lua-language-server"] = {
        cmd = { "lua-language-server" },
        languages = { "lua" },
      },
      ["bashls"] = {
        cmd = { "bash-language-server", "start" },
        languages = { "bash" },
      },
    },
  },
  on_init = function(client)
    -- to use semanticTokens/full/delta
    client.server_capabilities.semanticTokensProvider.range = false
  end,
}
