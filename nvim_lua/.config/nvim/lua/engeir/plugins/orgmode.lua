return {
    "nvim-orgmode/orgmode",
    enabled = false,
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
        orgmode = require("orgmode")
        -- Load custom tree-sitter grammar for org filetype
        orgmode.setup_ts_grammar()
        -- Tree-sitter configuration
        require("nvim-treesitter.configs").setup({
            -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { "org" }, -- Required for spellcheck, some LaTex highlights and code block highlights that do not have ts grammar
            },
            ensure_installed = { "org" },                      -- Or run :TSUpdate org
        })

        require("orgmode").setup({
            org_agenda_files = { "~/projects/todo/org/*", "~/my-orgs/**/*" },
            org_default_notes_file = "~/projects/todo/org/refile.org",
        })
    end,
}
