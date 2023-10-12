return {
    -- https://github.com/latex-lsp/texlab/wiki/Configuration
    texlab = {
        chktex = {
            onEdit = true,
            onOpenAndSave = true,
        },
        experimental = {
            -- citationCommands is wrong, but I don't think a reference commands option
            -- is available
            -- citationCommands = {
            --     "subref",
            -- },
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
