local ok, grammar = pcall(require, "grammar-guard")
if not ok then
    return
end
-- local ok2, nvim_lsp = pcall(require, "lspconfig")
-- if not ok2 then
--     return
-- end

grammar.init()
-- The below is implemented in nvim-lspconfig.lua. Commented out here to avoid
-- duplicating.
-- nvim_lsp.grammar_guard.setup({
--     cmd = { "/home/een023/.local/share/nvim/lsp_servers/ltex/ltex-ls/bin/ltex-ls" }, -- add this if you install ltex-ls yourself
--     settings = {
--         ltex = {
--             enabled = { "latex", "tex", "bib", "markdown" },
--             language = "en-GB",
--             diagnosticSeverity = "information",
--             setenceCacheSize = 2000,
--             additionalRules = {
--                 enablePickyRules = true,
--                 motherTongue = "en",
--             },
--             trace = { server = "verbose" },
--             dictionary = {},
--             disabledRules = {},
--             hiddenFalsePositives = {},
--         },
--     },
-- })
