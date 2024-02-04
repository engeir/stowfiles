return {
    "anufrievroman/vim-angry-reviewer",
    ft = { "tex" },
    cond = IS_KNOWN,
    init = function()
        vim.g.AngryReviewerEnglish = "british"
    end,
}
