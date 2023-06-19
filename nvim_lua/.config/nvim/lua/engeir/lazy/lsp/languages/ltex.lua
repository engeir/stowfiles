local path = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"
-- local engb = vim.fn.expand("~") .. "/.local/share/nvim/lsp_servers/ltex/en-GB.txt"
local words = {}

for word in io.open(path, "r"):lines() do
    table.insert(words, word)
end
-- for word in io.open(engb, "r"):lines() do
--     table.insert(words, word)
-- end
return {
    settings = {
        ltex = {
            enabled = { "latex", "tex", "bib", "rst" },
            language = "en-GB",
            diagnosticSeverity = "information",
            setenceCacheSize = 2000,
            additionalRules = {
                enablePickyRules = true,
                motherTongue = "en",
            },
            trace = { server = "verbose" },
            dictionary = {
                ["en-GB"] = words,
                ["de-DE"] = {},
            },
            disabledRules = {},
            hiddenFalsePositives = {},
        },
    },
    -- cmd = {
    --     vim.fn.expand("~") .. "/.local/share/nvim/lsp_servers/ltex/ltex-ls/bin/ltex-ls",
    -- },
}
