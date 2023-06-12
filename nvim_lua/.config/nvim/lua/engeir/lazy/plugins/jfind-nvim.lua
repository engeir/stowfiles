return {
    "jake-stewart/jfind.nvim",
    cond = IS_KNOWN and EXECUTABLE("jfind"),
    keys = {
        { "<c-f>" },
    },
    config = function()
        require("jfind").setup({
            exclude = {
                ".git",
                ".vscode",
                ".sass-cache",
                ".class",
                "__pycache__",
                "node_modules",
                "target",
                "build",
                "tmp",
                "dist",
                "*.iml",
                "*.meta",
                "*.png",
                "*.webp",
            },
            border = "rounded",
            tmux = true,
            key = "<c-f>",
        })
    end,
}
