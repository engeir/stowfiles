return {
  {
    "zbirenbaum/copilot.lua",
    enabled = false,
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        filetypes = { lua = true, markdown = true, tex = false, python = false },
        panel = {
          enabled = true,
          auto_refresh = true,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>",
          },
          layout = {
            position = "right", -- | bottom | top | left | right
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = true,
          autotrigger = true,
          keymap = {
            next = "<M-k>",
            prev = "<M-j>",
          },
        },
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    enabled = false,
    config = function() require("copilot_cmp").setup() end,
  },
}
