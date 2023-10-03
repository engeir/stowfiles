return {
    -- https://github.com/latex-lsp/texlab/wiki/Configuration
    texlab = {
        chktex = {
            onEdit = true,
            onOpenAndSave = true,
        },
        experimental = {
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
    },
}
