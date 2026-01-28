return {
  "stevearc/conform.nvim",
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
        bib = { "llf", stop_after_first = true },
        css = { "dprint", "prettierd", stop_after_first = true },
        d2 = { "d2" },
        dockerfile = { "dprint" },
        go = { "gofmt" },
        html = { "dprint" },
        injected = { options = { lang_to_ext = { latex = "tex" } } },
        javascript = { "dprint", "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "dprint", "prettierd", "prettier", stop_after_first = true },
        json = { "jq", "dprint", stop_after_first = true },
        jsonc = { "dprint" },
        just = { "just" },
        lua = { "stylua", "injected" },
        markdown = { "prettier", stop_after_first = false },
        python = { "ruff_format", "ruff_fix", lsp_format = "first" },
        ruby = { "rubyfmt" },
        rust = { "rustfmt" },
        sh = { "shfmt", "shellharden", "shellcheck", "injected" },
        tex = { "tex-fmt", "llf", stop_after_first = true },
        toml = { "taplo", "dprint", stop_after_first = true },
        typescript = { "prettierd", "dprint", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "dprint", "prettier", stop_after_first = true },
        typst = { "typstyle", lsp_format = "first" },
        vim = { "vimfmt", "injected" },
        yaml = function(bufnr)
          return { first(bufnr, "yamlfmt", "prettierd", "prettier"), "injected" }
        end,
        zsh = { "shfmt", "shellharden", "shellcheck", "injected" },
      },
      format_on_save = nil,
      format_after_save = nil,
      -- Set the log level. Use `:ConformInfo` to see the location of the log file.
      log_level = vim.log.levels.ERROR,
      -- Conform will notify you when a formatter errors
      notify_on_error = true,
      -- Define custom formatters here
      formatters = {
        d2 = {
          command = "d2",
          args = {
            "fmt",
            "$FILENAME",
          },
          stdin = false,
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
    vim.api.nvim_create_user_command(
      "Format",
      function(opts)
        require("conform").format({
          timeout_ms = opts.fargs[1] or 1500,
          async = false,
          lsp_fallback = true,
        })
      end,
      { desc = "Format buffer", nargs = "?" }
    )
  end,
}
