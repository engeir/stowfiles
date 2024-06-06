return {
  -- "anufrievroman/vim-angry-reviewer",
  dir = "/home/een023/projects/vim-angry-reviewer/",
  ft = { "tex" },
  keys = {
    { "cra", "<cmd>AngryReviewer<CR>", desc = "AngryReviewer" },
  },
  init = function()
    vim.g.AngryReviewerEnglish = "british"
  end,
}
