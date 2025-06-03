return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  cmd = { "ObsidianQuickSwitch" }, -- "ObsidianWorkspace"
  keys = {
    { "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>" },
    { "<leader>on", "<cmd>ObsidianNew<CR>" },
  },
  -- ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  event = {
    "BufReadPre " .. vim.fn.expand("~") .. "/.local/share/obsidian-vault/Work/**.md",
    "BufNewFile " .. vim.fn.expand("~") .. "/.local/share/obsidian-vault/Work/**.md",
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
    -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
    completion = {
      -- Enables completion using nvim_cmp
      nvim_cmp = false,
      -- Enables completion using blink.cmp
      blink = true,
      -- Trigger completion at 2 chars.
      min_chars = 2,
    },
  },
}
