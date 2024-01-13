local colors = require("colors")
local cal = sbar.add("item", {
    icon = {
        padding_left = 5,
        padding_right = 0,
        font = {
            style = "Black",
            size = 12.0,
        },
    },
    label = {
        padding_right = 5,
        align = "right",
    },
    background = { corner_radius = 5, color = colors.bar.bg, padding_right = 2, padding_left = 2 },
    position = "right",
    update_freq = 1,
})

local function update()
    local date = os.date("%a. %d %b.")
    local time = os.date("%H:%M")
    cal:set({ icon = date, label = { string = time, font = { size = 12 } } })
end

cal:subscribe("routine", update)
cal:subscribe("forced", update)
