return {
  "airblade/vim-rooter",
  event = { "BufReadPre", "BufNewFile" },
  init = function()
    vim.g.rooter_patterns = { ".git", "Makefile", "*.sln", "build/env.sh", ".obsidian" }
  end,
}
