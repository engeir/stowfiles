return {
  "airblade/vim-rooter",
  init = function()
    vim.g.rooter_patterns =
      { ".git", "Makefile", "*.sln", "build/env.sh", "pyproject.toml" }
  end,
}
