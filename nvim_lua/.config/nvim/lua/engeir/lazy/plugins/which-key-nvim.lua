return {
  "folke/which-key.nvim",
  enabled = true,
  event = "VeryLazy",
  -- init = function()
  --     vim.o.timeout = true
  --     vim.o.timeoutlen = 300
  -- end,
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
    {
      "[<space>",
      function()
        require("which-key").show({ keys = "[", loop = true })
      end,
      desc = "Hydra Mode (which-key)",
    },
    {
      "]<space>",
      function()
        require("which-key").show({ keys = "]", loop = true })
      end,
      desc = "Hydra Mode (which-key)",
    },
    {
      "<c-w><space>",
      function()
        require("which-key").show({ keys = "<c-w>", loop = true })
      end,
      desc = "Window Hydra Mode (which-key)",
    },
  },
  config = function() -- This is the function that runs, AFTER loading
    require("which-key").setup()

    local wk = require("which-key")
    wk.add({
      { "<leader>b", group = "Buffer" },
      { "<leader>f", group = "Find" },
      { "<leader>g", group = "Git" },
      { "<leader>h", group = "Harpoon", icon = "󱡀" },
      { "<leader>j", group = "Just", icon = "󰖷" },
      { "<leader>t", group = "Terminal" },
      { "<leader>u", group = "Ui" },
      { "<leader>ut", "<cmd>tabnew<cr>", desc = "Create new tab" },
      { "<leader>w", group = "Workspace" },
      { "<leader>ws", "<cmd>source %<cr>", desc = "Source file" },
      { "cr", group = "Refactor" },
      { "]", group = "Next/Prev" },
      { "[", group = "Last/First" },
    })
    -- wk.show({
    --   keys = "<c-w>",
    --   loop = true, -- this will keep the popup open until you hit <esc>
    -- })
    -- wk.show({
    --   keys = "]",
    --   loop = true, -- this will keep the popup open until you hit <esc>
    -- })
    -- wk.show({
    --   keys = "[",
    --   loop = true, -- this will keep the popup open until you hit <esc>
    -- })
  end,
}
