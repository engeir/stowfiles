local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
    return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

-- https://github.com/prettier-solidity/prettier-plugin-solidity
null_ls.setup({
    debug = false,
    sources = {
        code_actions.gitsigns,
        code_actions.proselint,
        -- code_actions.refactoring,
        -- diagnostics.flake8,
        diagnostics.golangci_lint,
        diagnostics.jsonlint,
        diagnostics.markdownlint.with({
            extra_args = { "-c", vim.fn.expand("~") .. "/.config/mdl/.markdownlint.jsonc" },
        }),
        diagnostics.mypy,
        diagnostics.proselint,
        diagnostics.pydocstyle,
        diagnostics.shellcheck,
        formatting.black.with({ extra_args = { "--fast" } }),
        formatting.fixjson,
        formatting.gofmt,
        formatting.latexindent,
        -- formatting.markdownlint.with({
        --     extra_args = { "-c", vim.fn.expand("~") .. "/.config/mdl/.markdownlint.jsonc" },
        -- }), -- Using `prettierd` instead
        formatting.prettierd.with({
            filetypes = { "toml", "md", "markdown" },
            -- args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
        }),
        formatting.shellharden,
        formatting.shfmt.with({ extra_args = { "-i=4" } }),
        formatting.stylua.with({ extra_args = { "--indent-type=Spaces" } }),
        formatting.taplo,
    },
})
