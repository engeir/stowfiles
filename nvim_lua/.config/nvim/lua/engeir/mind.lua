local ok, mind = pcall(require, "mind")
if not ok then
    return
end

mind.setup({
    ui = {
        close_on_file_open = true,
        icon_preset = {
            { " ", "Sub-project" },
            { " ",  "Journal, newspaper, weekly and daily news" },
            { " ", "For when you have an idea" },
            { " ",  "Note taking?" },
            { "陼 ",   "Task management" },
            { " ", "Uncheck, empty square or backlog" },
            { " ", "Full square or on-going" },
            { " ",  "Check or done" },
            { " ", "Trash bin, deleted, cancelled, etc." },
            { " ",  "GitHub" },
            { " ",  "Monitoring" },
            { " ",  "Internet, Earth, everyone!" },
            { " ",  "Frozen, on-hold" },
            { "🚧 ",    "WIP" },
        },
    },
})
