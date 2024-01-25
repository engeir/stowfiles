local icons = require("icons")
local colors = require("colors")

local battery = sbar.add("item", {
    position = "right",
    icon = {
        padding_left = 5,
        font = {
            style = "Regular",
            size = 16.0,
        },
    },
    background = {
        corner_radius = 5,
        color = colors.bar.bg,
        padding_right = 2,
        padding_left = 2,
    },
    label = { drawing = true, padding_right = 5 },
    update_freq = 10,
})

local function battery_update()
    local file = assert(io.popen("pmset -g batt"))
    local batt_info = assert(file:read("a"))
    local icon = "!"
    local charge_str = ""

    local found, _, charge = batt_info:find("(%d+)%%")
    if found then
        charge_str = charge .. " %"
        charge = tonumber(charge)
    end
    if string.find(batt_info, "AC Power") then
        icon = icons.battery.charging
    else
        if found and charge > 80 then
            icon = icons.battery._100
        elseif found and charge > 60 then
            icon = icons.battery._75
        elseif found and charge > 40 then
            icon = icons.battery._50
        elseif found and charge > 20 then
            icon = icons.battery._25
        else
            icon = icons.battery._0
        end
    end

    battery:set({ icon = { string = icon }, label = { string = charge_str } })
end

battery:subscribe("routine", battery_update)
-- battery:subscribe("power_source_change", battery_update)
-- battery:subscribe("system_woke", battery_update)
