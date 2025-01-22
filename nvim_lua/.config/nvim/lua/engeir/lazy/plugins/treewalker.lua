---@module "lazy"
---@type LazySpec
return {
  "aaronik/treewalker.nvim",
  keys = {
    {
      "<C-M-h>",
      "<cmd>Treewalker Left<cr>",
      desc = "Move out to the parent tree-sitter object",
      mode = { "n", "v" },
    },
    {
      "<C-M-j>",
      "<cmd>Treewalker Down<cr>",
      desc = "Move down to the next similar tree-sitter object",
      mode = { "n", "v" },
    },
    {
      "<C-M-k>",
      "<cmd>Treewalker Up<cr>",
      desc = "Move up to the previous similar tree-sitter object",
      mode = { "n", "v" },
    },
    {
      "<C-M-l>",
      "<cmd>Treewalker Right<cr>",
      desc = "Move into the child tree-sitter object",
      mode = { "n", "v" },
    },
    { -- Same as SwapRight, except this also move stuff across parent siblings.
      "]9",
      "<cmd>Treewalker SwapDown<cr>",
      desc = "Move down to the next similar tree-sitter object",
    },
    { -- Same as SwapLeft, except this also move stuff across parent siblings.
      "[8",
      "<cmd>Treewalker SwapUp<cr>",
      desc = "Move up to the previous similar tree-sitter object",
    },
  },
}
