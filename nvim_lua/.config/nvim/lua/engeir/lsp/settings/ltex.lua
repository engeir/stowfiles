return {
    settings = {
        ltex = {
            enabled = { "latex", "tex", "bib", "markdown", "rst" },
            language = "en-GB",
            diagnosticSeverity = "information",
            setenceCacheSize = 2000,
            additionalRules = {
                enablePickyRules = true,
                motherTongue = "en",
            },
            trace = { server = "verbose" },
            dictionary = {
                ["en-GB"] = { "Pinatubo", ":/home/een023/.local/share/nvim/lsp_servers/ltex/en-GB.txt" },
                ["de-DE"] = {},
            },
            disabledRules = {},
            hiddenFalsePositives = {},
        },
    },
    cmd = {
        vim.fn.expand("~") .. "/.local/share/nvim/lsp_servers/ltex/ltex-ls/bin/ltex-ls",
    },
}
