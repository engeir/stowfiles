local opts = { noremap = true, silent = true }
return {
  "ziontee113/color-picker.nvim",
  -- Use ccc.nvim (ccc-nvim.lua) instead
  enabled = false,
  init = function()
    vim.cmd([[hi FloatBorder guibg=NONE]]) -- if you don't want weird border background colors around the popup.
  end,
  opts = {
    -- for changing icons & mappings
    -- ["icons"] = { "?", "?" },
    -- ["icons"] = { "?", "?" },
    -- ["icons"] = { "?", "?" },
    -- ["icons"] = { "?", "?" },
    -- ["icons"] = { "?", "?" },
    ["icons"] = { "Óà´", "Óà´" },
    ["border"] = "rounded", -- none | single | double | rounded | solid | shadow
    ["keymap"] = { -- mapping example:
      ["U"] = "<Plug>ColorPickerSlider5Decrease",
      ["O"] = "<Plug>ColorPickerSlider5Increase",
    },
  },
  keys = {
    { "<C-c>", "<cmd>PickColor<cr>", opts },
    { "<C-c>", "<cmd>PickColorInsert<cr>", opts, mode = "i" },
  },
}
