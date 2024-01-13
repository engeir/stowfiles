local front_app = sbar.add("item", {
    icon = {
        -- font = "sketchybar-app-font:Regular:11.0",
        font = {
            family = "sketchybar-app-font",
            style = "Regular",
            size = "12",
        },
        y_offset = -2,
        drawing = true,
    },
    label = {
        font = {
            style = "Black",
            size = 11.0,
        },
    },
})

front_app:subscribe("front_app_switched", function(env)
    local file = assert(io.popen("~/stowfiles/sketchybar/.config/sketchybar/plugins/icon_map_fn.sh " .. env.INFO))
    local icon = assert(file:read("a"))
    front_app:set({
        icon = { string = icon },
        label = {
            string = env.INFO,
        },
    })

    -- Or equivalently:
    -- sbar.set(env.NAME, {
    --   label = {
    --     string = env.INFO
    --   }
    -- })
end)
