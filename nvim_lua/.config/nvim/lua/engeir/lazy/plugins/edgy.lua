return {
  "folke/edgy.nvim",
  event = "VeryLazy",
  init = function()
    vim.opt.laststatus = 3
    vim.opt.splitkeep = "screen"
  end,
  opts = {
    bottom = {
      "Trouble",
      { ft = "qf", title = "QuickFix" },
      {
        ft = "help",
        size = { height = 20 },
        -- only show help buffers
        filter = function(buf)
          return vim.bo[buf].buftype == "help"
        end,
      },
      { ft = "spectre_panel", size = { height = 0.4 } },
    },
    right = {
      -- floaterm at the right with a width of 45% of the screen
      {
        ft = "floaterm",
        size = { width = 0.45 },
        -- exclude floating windows
        filter = function(buf, win)
          return vim.api.nvim_win_get_config(win).relative == ""
        end,
      },
    },
    left = {
      {
        title = function()
          local buf_name = vim.api.nvim_buf_get_name(0) or "[No Name]"
          return vim.fn.fnamemodify(buf_name, ":t")
        end,
        ft = "Outline",
        pinned = true,
        open = "SymbolsOutlineOpen",
      },
    },
  },
}
