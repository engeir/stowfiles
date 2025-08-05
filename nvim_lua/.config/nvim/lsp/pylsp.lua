return {
  -- https://github.com/latex-lsp/texlab/wiki/Configuration
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = { "W391" },
          maxLineLength = 88,
        },
        pylsp_rope = { rename = true },
        -- rope_autoimport = { enabled = true },
        rope_autoimport = {
          memory = true,
          enabled = true,
          { completions = { enabled = true } },
        },
        rope_completion = { enabled = true },
      },
    },
  },
}
