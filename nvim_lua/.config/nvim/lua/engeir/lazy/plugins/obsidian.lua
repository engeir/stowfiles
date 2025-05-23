return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  cmd = { "ObsidianQuickSwitch" }, -- "ObsidianWorkspace"
  -- ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  event = {
    "BufReadPre " .. vim.fn.expand("~") .. "/.local/share/obsidian-vault/**.md",
    "BufNewFile " .. vim.fn.expand("~") .. "/.local/share/obsidian-vault/**.md",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    ui = { enable = false },
    workspaces = {
      {
        name = "personal",
        path = "~/.local/share/obsidian-vault",
      },
      -- {
      --     name = "work",
      --     path = "~/vaults/work",
      -- },
    },
  },
}
