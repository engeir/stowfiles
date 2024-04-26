return {
  -- https://github.com/latex-lsp/texlab/wiki/Configuration
  settings = {
    texlab = {
      chktex = {
        onEdit = true,
        onOpenAndSave = true,
      },
      experimental = {
        followPackageLinks = true,
        citationCommands = {
          "citeA",
        },
        labelReferenceCommands = {
          "subref",
        },
        mathEnvironments = {
          "align*",
          "equation",
        },
      },
      formatterLineLength = -1, -- bib files
      forwardSearch = {
        executable = "zathura",
      },
      latexindent = { modifyLineBreaks = true },
      build = {
        executable = "tectonic",
        args = {
          "-X",
          "compile",
          "%f",
          "--synctex",
          "--keep-logs",
          "--keep-intermediates",
        },
      },
    },
  },
}
