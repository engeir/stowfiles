return {
    "tpope/vim-dadbod",
    enabled = IS_KNOWN,
    dependencies = {
        "kristijanhusak/vim-dadbod-ui",
        "kristijanhusak/vim-dadbod-completion",
    },
    config = true,
    cmd = {"DBUIToggle", "DBUI"},
}
