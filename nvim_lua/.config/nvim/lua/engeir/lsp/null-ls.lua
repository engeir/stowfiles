local ok, null_ls = pcall(require, "null-ls")
if not ok then
    return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

-- https://github.com/prettier-solidity/prettier-plugin-solidity
null_ls.setup({
    -- debug = true,
    -- Stopped working all of a sudden. Crashes `gq<motion>`.
    sources = {
        -- code_actions.gitsigns,
        -- code_actions.proselint,
        -- code_actions.refactoring,
        -- diagnostics.flake8,
        diagnostics.golangci_lint,
        diagnostics.jsonlint,
        diagnostics.rstcheck,
        diagnostics.markdownlint.with({
            extra_args = { "-c", vim.fn.expand("~") .. "/.config/mdl/.markdownlint.jsonc" },
        }),
        diagnostics.mypy,
        -- diagnostics.vale,
        -- diagnostics.proselint,
        -- diagnostics.pydocstyle,
        diagnostics.shellcheck,
        formatting.beautysh,
        formatting.bibclean.with({ extra_args = { "--max-width", "0", "--no-fix-names" } }),
        formatting.black.with({ extra_args = { "--fast" } }),
        formatting.fixjson,
        formatting.gofmt,
        formatting.latexindent.with({
            extra_args = { "-l", vim.fn.expand("~") .. "/.config/latexindent/latexindent.yaml" },
        }),
        -- formatting.markdownlint.with({
        --     extra_args = { "-c", vim.fn.expand("~") .. "/.config/mdl/.markdownlint.jsonc" },
        -- }), -- Using `prettierd` instead
        formatting.prettierd.with({
            filetypes = { "yml", "yaml", "toml", "md", "markdown" },
            -- args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
        }),
        formatting.ruff,
        formatting.shellharden,
        formatting.shfmt.with({ extra_args = { "-i=4" } }),
        formatting.stylua.with({ extra_args = { "--indent-type=Spaces" } }),
        formatting.taplo,
    },
})

-- null-ls has an issue with gqq when an lsp is attached, but the below solves it. See:
-- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1259
-- Use internal formatting for bindings like gq.
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        vim.bo[args.buf].formatexpr = nil
    end,
})
