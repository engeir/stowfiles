return {
  "folke/which-key.nvim",
  enabled = true,
  event = "VimEnter",
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
      f = { name = "[F]ind", _ = "which_key_ignore" },
      u = {
        name = "[U]i",
        _ = "which_key_ignore",
        t = { "<cmd>tabnew<cr>", "Create new tab" },
      },
      w = {
        name = "[W]orkspace",
        s = { "<cmd>source %<cr>", "Source file" },
      },
    }, { prefix = "<leader>" })
    wkr({
      r = { name = "[R]efactor", _ = "which_key_ignore" },
    }, { prefix = "c" })
  end,
}
