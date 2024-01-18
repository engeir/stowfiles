local whitelist = { ["Spotify"] = true, ["Music"] = true }

local media = sbar.add("item", {
    icon = {
        drawing = true,
        font = {
            family = "sketchybar-app-font",
            style = "Regular",
            size = "11",
        },
        y_offset = -1,
        string = ":music:"
    },
    position = "center",
    updates = true,
})

media:subscribe("media_change", function(env)
    if whitelist[env.INFO.app] then
        media:set({
            drawing = (env.INFO.state == "playing") and true or false,
            label = env.INFO.artist .. ": " .. env.INFO.title,
        })
    end
end)
