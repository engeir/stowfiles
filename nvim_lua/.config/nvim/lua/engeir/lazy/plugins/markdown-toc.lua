return {
  {
    "mzlogin/vim-markdown-toc",
    enabled = true,
    config = function()
      vim.g.vmt_list_item_char = "-"
    end,
  },
  { "richardbizik/nvim-toc", enabled = false, config = true },
}
