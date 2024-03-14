return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
            bash = { "shellcheck" },
            go = { "golangcilint" },
            json = { "jsonlint" },
            markdown = { "markdownlint" }, -- vale is run via lsp (vale_ls)
            python = { "mypy" }, -- ruff is run via lsp, don't need it here
            -- rst = { "rstcheck" },  -- rstcheck doesn't seem to work
            sh = { "shellcheck" },
            -- tex = { "chktex" },
            zsh = { "shellcheck" },
        }
        -- Custom linters

        -- Expand args
        local markdownlint = require("lint").linters.markdownlint
        markdownlint.args = {
            "-c",
            vim.fn.expand("~") .. "/.config/mdl/.markdownlint.jsonc",
        }

        -- We do clear = true so that when we get this autocmd group, any pre-existing
        -- autocmd within it will get cleard
        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = lint_augroup,
            callback = function()
                lint.try_lint()
            end,
        })
        vim.keymap.set("n", "<leader>sl", function()
            lint.try_lint()
        end, { desc = "Run linter" })
    end,
}
