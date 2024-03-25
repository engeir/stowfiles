return {
  "nvim-neo-tree/neo-tree.nvim",
  enabled = IS_KNOWN,
  branch = "v2.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  config = function()
    -- Unless you are still migrating, remove the deprecated commands from v1.x
    vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
    require("neo-tree").setup({
      enable_git_status = true,
      enable_diagnostics = true,
      window = {
        position = "right",
        width = 60,
      },
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
      event_handlers = {

        {
          event = "file_opened",
          handler = function()
            require("neo-tree").close_all()
          end,
        },
      },
      source_selector = {
        winbar = true,
        statusline = false,
      },
    })
  end,
  keys = {
    { "<leader>pf", "<cmd>NeoTreeReveal<CR>", desc = "NeoTree Find File" },
    { "<leader>pp", "<cmd>NeoTreeShowToggle<CR>", desc = "NeoTree Toggle" },
  },
}
