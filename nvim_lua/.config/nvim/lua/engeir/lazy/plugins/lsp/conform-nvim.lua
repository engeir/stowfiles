return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("conform").setup({
            -- Map of filetype to formatters
            formatters_by_ft = {
                bash = { "shfmt", "shellharden", "shellcheck_formatter" },
                javascript = { { "prettierd", "prettier" } },
                lua = { "stylua" },
                markdown = { "dprint" },
                python = { "isort", "blackd" },
                sh = { "shfmt", "shellharden", "shellcheck_formatter" },
                zsh = { "shfmt", "shellharden", "shellcheck_formatter" },
                ["*"] = { "trim_whitespace" },
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
                    exit_codes = { 0, 1 },
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
                shellcheck_formatter = {
                    command = "sh",
                    args = { "-c", "shellcheck $0 --format=diff | patch $0 -o-", "$FILENAME" },
                    stdin = true,
                    stderr = true,
                },
            },
        })

        local shfmt = require("conform.formatters.shfmt")
        shfmt.args = function()
            return { "-i=4", "-ci", "-s", "-bn" }
        end
        local stylua = require("conform.formatters.stylua")
        stylua.args = function()
            return { "--indent-type=Spaces" }
        end
    end,
}
