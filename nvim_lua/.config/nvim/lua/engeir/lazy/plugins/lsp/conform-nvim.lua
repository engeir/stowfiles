return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>sf",
      function()
        require("conform").format({
          async = false,
          lsp_fallback = true,
          timeout_ms = 500,
        })
      end,
      mode = { "n", "v" },
      desc = "Format buffer",
    },
  },
  config = function()
    require("conform").setup({
      -- Map of filetype to formatters
      formatters_by_ft = {
        ["_"] = { "trim_whitespace", "trim_newlines" },
        bash = { "shfmt", "shellharden", "shellcheck", "beautysh" },
        css = { { "dprint", "prettierd" } },
        d2 = { "d2" },
        dockerfile = { "dprint" },
        go = { "gofmt" },
        just = { "just" },
        javascript = { { "prettierd", "dprint", "prettier" } },
        javascriptreact = { { "prettierd", "dprint", "prettier" } },
        json = { "dprint" },
        jsonc = { "dprint" },
        lua = { "stylua" },
        markdown = { "dprint" },
        python = { "ruff_format", "ruff_fix" },
        rust = { "rustfmt" },
        sh = { "shfmt", "shellharden", "shellcheck", "beautysh" },
        toml = { "dprint", "taplo" },
        typescript = { { "prettierd", "dprint", "prettier" } },
        typescriptreact = { { "prettierd", "dprint", "prettier" } },
        yaml = { { "prettierd", "prettier" } },
        zsh = { "shfmt", "shellharden", "shellcheck", "beautysh" },
      },
      format_on_save = nil,
      format_after_save = nil,
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
          cwd = require("conform.util").root_file({
            ".git",
            "pyproject.toml",
            "setup.py",
          }),
          -- When cwd is not found, don't run the formatter (default false)
          require_cwd = false,
          -- When returns false, the formatter will not be used
          condition = function(ctx)
            return vim.fs.basename(ctx.filename) ~= "README.md"
          end,
          -- Exit codes that indicate success (default {0})
          exit_codes = { 0 },
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
  end,
}
