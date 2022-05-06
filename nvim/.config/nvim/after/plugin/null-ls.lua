-- https://github.com/ChristianChiarulli/nvim/blob/master/lua/user/lsp/null-ls.lua
local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
    return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

-- https://github.com/prettier-solidity/prettier-plugin-solidity
-- npm install --save-dev prettier prettier-plugin-solidity
null_ls.setup({
    debug = false,
    sources = {
        formatting.prettier.with({
            filetypes = {
                "javascript",
                "javascriptreact",
                "typescript",
                "typescriptreact",
                "vue",
                "css",
                "scss",
                "less",
                "html",
                -- "json",
                "yaml",
                -- "markdown",
                "graphql",
                "solidity",
            },
            extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
        }),
        formatting.bibclean.with({ extra_args = { "--max-width", "0", "--no-fix-names" } }),
        formatting.black.with({ extra_args = { "--fast" } }),
        formatting.fixjson,
        formatting.gofmt,
        formatting.latexindent,
        formatting.markdownlint.with({ extra_args = { "-c", "/home/een023/.config/mdl/.markdownlint.jsonc" } }),
        formatting.shellharden,
        formatting.shfmt.with({ extra_args = { "-i=4" } }),
        formatting.stylua.with({ extra_args = { "--indent-type=Spaces" } }),
        formatting.taplo,
        diagnostics.golangci_lint,
        diagnostics.jsonlint,
        diagnostics.markdownlint.with({ extra_args = { "-c", "/home/een023/.config/mdl/.markdownlint.jsonc" } }),
        diagnostics.mypy,
        diagnostics.pydocstyle,
        diagnostics.shellcheck,
        -- diagnostics.flake8,
        -- diagnostics.mdl.with({ extra_args = { "-c", "/home/een023/.config/mdl/.markdownlint.jsonc" }}),
    },
    -- This format-on-save command is a bit dangerous, you probably want the option of
    -- just saving and not format on any occasion.
    -- on_attach = function(client)
    --     if client.resolved_capabilities.document_formatting then
    --         vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    --     end
    -- end,
})
