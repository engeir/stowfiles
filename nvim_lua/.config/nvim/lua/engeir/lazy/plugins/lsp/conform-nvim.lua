return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    { -- copy/pasta from https://github.com/stevearc/dotfiles/blob/master/.config/nvim/lua/plugins/format.lua#L8-L21
      "=",
      function()
        require("conform").format(
          { timeout_ms = 500, async = false, lsp_fallback = true },
          function(err)
            if not err then
              if vim.startswith(vim.api.nvim_get_mode().mode:lower(), "v") then
                vim.api.nvim_feedkeys(
                  vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
                  "n",
                  true
                )
              end
            end
          end
        )
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  config = function()
    ---@param bufnr integer
    ---@param ... string
    ---@return string
    local function first(bufnr, ...)
      local conform = require("conform")
      for i = 1, select("#", ...) do
        local formatter = select(i, ...)
        if conform.get_formatter_info(formatter, bufnr).available then
          return formatter
        end
      end
      return select(1, ...)
    end

    require("conform").setup({
      -- Map of filetype to formatters
      formatters_by_ft = {
        ["_"] = { "trim_whitespace", "trim_newlines" },
        bash = function(bufnr)
          return {
            first(bufnr, "shfmt", "shellharden", "shellcheck", "beautysh"),
            "injected",
          }
        end,
        css = { "dprint", "prettierd", stop_after_first = true },
        d2 = { "d2" },
        dockerfile = { "dprint" },
        go = { "gofmt" },
        javascript = { "prettierd", "dprint", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "dprint", "prettier", stop_after_first = true },
        json = { "dprint" },
        jsonc = { "dprint" },
        just = { "just" },
        lua = { "stylua", "injected" },
        markdown = { "dprint", "injected" },
        python = { "ruff_format", "ruff_fix", lsp_format = "first" },
        rust = { "rustfmt" },
        sh = function(bufnr)
          return {
            first(bufnr, "shfmt", "shellharden", "shellcheck", "beautysh"),
            "injected",
          }
        end,
        tex = { "llf" },
        toml = { "dprint", "taplo", stop_after_first = true },
        typescript = { "prettierd", "dprint", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "dprint", "prettier", stop_after_first = true },
        typst = { "typstyle", lsp_format = "first" },
        vim = { "vimfmt", "injected" },
        yaml = function(bufnr)
          return { first(bufnr, "yamlfmt", "prettierd", "prettier"), "injected" }
        end,
        zsh = function(bufnr)
          return {
            first(bufnr, "shfmt", "shellharden", "shellcheck", "beautysh"),
            "injected",
          }
        end,
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

    -- Set up a custom function that takes the timeout as an argument
    vim.api.nvim_create_user_command("Format", function(opts)
      require("conform").format({
        timeout_ms = opts.fargs[1] or 1500,
        async = false,
        lsp_fallback = true,
      })
    end, { desc = "Format buffer", nargs = "?" })
  end,
}
