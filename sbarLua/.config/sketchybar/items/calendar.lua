local cal = sbar.add("item", {
    icon = {
        padding_right = 0,
        font = {
            style = "Black",
            size = 12.0,
        },
    },
    label = {
        width = 45,
        align = "right",
    },
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
