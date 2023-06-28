local ok, null_ls = pcall(require, "null-ls")
if not ok then
    return
end

-- Nice:
-- https://github.com/jose-elias-alvarez/null-ls.nvim#parsing-cli-program-output
local check_exit_code = function(code, stderr)
    local success = code < 1

    if not success then
        -- can be noisy for things that run often (e.g. diagnostics), but can
        -- be useful for things that run on demand (e.g. formatting)
        print(stderr)
    end

    return success
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
-- local code_actions = null_ls.builtins.code_actions

local h = require("null-ls.helpers")
-- This works ...
local shellcheck_formatter = {
    name = "shellcheck",
    method = null_ls.methods.FORMATTING,
    filetypes = { "sh" },
    generator = null_ls.formatter({
        command = "sh",
        args = { "-c", "shellcheck $0 --format=diff | patch $0 -o-", "$FILENAME" },
        to_stdin = true,
        from_stderr = true,
        check_exit_code = check_exit_code,
    }),
}
null_ls.register(shellcheck_formatter)
local blackd = {
    name = "blackd",
    method = null_ls.methods.FORMATTING,
    filetypes = { "python" },
    generator = h.formatter_factory({
        command = "blackd-client",
        to_stdin = true,
        check_exit_code = check_exit_code,
    }),
}
-- local function dprint_config()
--     local lsputil = require("lspconfig.util")
--     local path = lsputil.path.join(vim.loop.cwd(), "dprint.json")
--     print(path)
--     if lsputil.path.exists(path) then
--         print("path exists")
--         return path
--     end
--     print("path doesnt exist")
--     return vim.fn.expand("~/.config/dprint/dprint.json")
-- end
local dprint = {
    name = "dprint",
    method = null_ls.methods.FORMATTING,
    filetypes = {
        "json",
        "markdown",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "toml",
        "dockerfile",
        "css",
    },
    generator = h.formatter_factory({
        command = "dprint",
        -- condition = function(utils)
        --     return utils.root_has_file 'dprint.json'
        -- end,
        args = {
            "fmt",
            "--config",
            -- dprint_config(),
            -- require('lspconfig.util').path.join(
            --     vim.loop.cwd(),
            --     'dprint.json'
            -- ),
            vim.fn.expand("~/.config/dprint/dprint.jsonc"),
            "--stdin",
            "$FILEEXT",
        },
        to_stdin = true,
        check_exit_code = check_exit_code,
    }),
}
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
        diagnostics.vale,
        diagnostics.chktex,
        -- diagnostics.pydocstyle,
        diagnostics.shellcheck,
        formatting.beautysh,
        formatting.bibclean.with({ extra_args = { "--max-width", "0" } }),
        -- formatting.black.with({ extra_args = { "--fast" } }),
        blackd,
        dprint,
        formatting.fixjson,
        formatting.fprettify,
        formatting.gofmt,
        formatting.isort,
        formatting.latexindent.with({
            extra_args = { "-m" },
        }),
        -- formatting.markdownlint.with({
        --     extra_args = { "-c", vim.fn.expand("~") .. "/.config/mdl/.markdownlint.jsonc" },
        -- }), -- Using `prettierd` instead
        formatting.prettierd.with({
            filetypes = { "css", "yml", "yaml", "toml" },
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
