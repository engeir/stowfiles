return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("conform").setup({
            -- Map of filetype to formatters
            formatters_by_ft = {
                bash = { "shfmt", "shellharden", "shellcheck", "beautysh" },
                css = { "dprint" },
                d2 = { "d2" },
                dockerfile = { "dprint" },
                javascript = { { "prettierd", "dprint", "prettier" } },
                javascriptreact = { { "prettierd", "dprint", "prettier" } },
                json = { "dprint" },
                lua = { "stylua" },
                markdown = { "dprint" },
                python = { "isort", "blackd", "ruff_fix", "ruff_format" },
                rust = { "rustfmt" },
                sh = { "shfmt", "shellharden", "shellcheck", "beautysh" },
                go = { "gofmt" },
                toml = { "dprint", "taplo" },
                typescript = { { "prettierd", "dprint", "prettier" } },
                typescriptreact = { { "prettierd", "dprint", "prettier" } },
                zsh = { "shfmt", "shellharden", "shellcheck", "beautysh" },
                ["_"] = { "trim_whitespace", "trim_newlines" },
            },
            format_on_save = false,
            format_after_save = false,
            -- Set the log level. Use `:ConformInfo` to see the location of the log file.
            log_level = vim.log.levels.ERROR,
            -- Conform will notify you when a formatter errors
            notify_on_error = true,
            -- Define custom formatters here
            formatters = {
                blackd = {
                    -- This can be a string or a function that returns a string
                    command = "blackd-client",
                    -- OPTIONAL - all fields below this are optional
                    -- A list of strings, or a function that returns a list of strings
                    -- args = { "$FILENAME" },
                    -- Send file contents to stdin, read new contents from stdout (default true)
                    -- When false, will create a temp file (will appear in "$FILENAME" args). The temp
                    -- file is assumed to be modified in-place by the format command.
                    stdin = true,
                    -- A function that calculates the directory to run the command in
                    cwd = require("conform.util").root_file({ ".git", "pyproject.toml", "setup.py" }),
                    -- When cwd is not found, don't run the formatter (default false)
                    require_cwd = false,
                    -- When returns false, the formatter will not be used
                    condition = function(ctx)
                        return vim.fs.basename(ctx.filename) ~= "README.md"
                    end,
                    -- Exit codes that indicate success (default {0})
                    exit_codes = { 0 },
                },
                d2 = {
                    command = "d2",
                    args = {
                        "fmt",
                        "$FILENAME",
                        "-",
                    },
                    stdin = true,
                },
                dprint = {
                    command = "dprint",
                    args = {
                        "fmt",
                        "--config",
                        vim.fn.expand("~/.config/dprint/dprint.jsonc"),
                        "--stdin",
                        "$FILENAME",
                    },
                    stdin = true,
                },
                -- shellcheck_formatter = {
                --     command = "sh",
                --     args = { "-c", "shellcheck $0 --format=diff | patch $0 -o-", "$FILENAME" },
                --     stdin = true,
                --     stderr = true,
                -- },
            },
        })

        -- Extend arguments
        local util = require("conform.util")
        local shfmt = require("conform.formatters.shfmt")
        require("conform").formatters.shfmt = vim.tbl_deep_extend("force", shfmt, {
            args = util.extend_args(shfmt.args, { "-i=4", "-ci", "-s", "-bn" }),
            range_args = util.extend_args(shfmt.args, { "-i=4", "-ci", "-s", "-bn" }),
        })
        local stylua = require("conform.formatters.stylua")
        require("conform").formatters.stylua = vim.tbl_deep_extend("force", stylua, {
            args = util.extend_args(stylua.args, { "--indent-type=Spaces" }),
            range_args = util.extend_args(stylua.args, { "--indent-type=Spaces" }), --"--indent-width=2"
        })

        -- Create a command `:Format`
        vim.api.nvim_create_user_command("Format", function(_)
            require("conform").format({ timeout_ms = 5000, async = false, lsp_fallback = true })
        end, { desc = "Format current buffer with conform.nvim or LSP" })
        vim.keymap.set({ "n", "v" }, "<leader>sf", function()
            require("conform").format({ timeout_ms = 5000, async = false, lsp_fallback = true })
        end, { desc = "Format" })
    end,
}
