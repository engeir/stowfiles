local uname = sbar.add("item", {
    position = "right",
    icon = { drawing = false },
    label = { string = ":: " .. os.getenv("USER") .. " ::", font = {
        size = 12.0,
    } },
})
