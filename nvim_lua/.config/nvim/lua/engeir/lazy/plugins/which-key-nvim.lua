return {
  "folke/which-key.nvim",
  enabled = true,
  event = "VeryLazy",
  -- init = function()
  --     vim.o.timeout = true
  --     vim.o.timeoutlen = 300
  -- end,
  config = function() -- This is the function that runs, AFTER loading
    require("which-key").setup()

    local wkr = require("which-key").register
    -- Document existing key chains
    wkr({
      -- c = { name = "[C]ode", _ = "which_key_ignore" },
      -- ["d"] = { name = "[D]ocument", _ = "which_key_ignore" },
      f = { name = "Find", _ = "which_key_ignore" },
      g = { name = "Git", _ = "which_key_ignore" },
      h = { name = "Harpoon", _ = "which_key_ignore" },
      j = { name = "Just", _ = "which_key_ignore" },
      t = { name = "Terminal", _ = "which_key_ignore" },
      u = {
        name = "Ui",
        _ = "which_key_ignore",
        t = { "<cmd>tabnew<cr>", "Create new tab" },
      },
      w = {
        name = "Workspace",
        s = { "<cmd>source %<cr>", "Source file" },
      },
    }, { prefix = "<leader>" })
    wkr({
      r = { name = "Refactor", _ = "which_key_ignore" },
    }, { prefix = "c" })
  end,
}
