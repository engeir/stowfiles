local colors = require("colors")
local icons = require("icons")

local volume_slider = sbar.add("slider", {
    position = "right",
    updates = true,
    label = { drawing = false },
    icon = { drawing = false },
    slider = {
        highlight_color = colors.blue,
        width = 0,
        background = {
            height = 6,
            corner_radius = 3,
            color = colors.bg2,
        },
        knob = {
            string = "􀀁",
            drawing = false,
        },
    },
})

local volume_icon = sbar.add("item", {
    position = "right",
    icon = {
        padding_left = 5,
        string = icons.volume._100,
        width = 25,
        align = "left",
        color = colors.grey,
        -- font = {
        --     style = "Regular",
        --     size = 14.0,
        -- },
    },
    background = { corner_radius = 5, color = colors.bar.bg, padding_right = 2, padding_left = 2 },
    label = {
        padding_right = 5,
        align = "left",
        -- font = {
        --     style = "Regular",
        --     size = 12.0,
        -- },
    },
})

volume_slider:subscribe("mouse.clicked", function(env)
    os.execute("osascript -e 'set volume output volume " .. env["PERCENTAGE"] .. "'")
end)

volume_slider:subscribe("volume_change", function(env)
    local volume = tonumber(env.INFO)
    local icon = icons.volume._0
    if volume > 99 then
        icon = icons.volume._100
    elseif volume > 60 then
        icon = icons.volume._100
    elseif volume > 30 then
        icon = icons.volume._66
    elseif volume > 10 then
        icon = icons.volume._33
    elseif volume > 0 then
        icon = icons.volume._10
    end

    volume_icon:set({ icon = { string = icon }, label = { string = volume .. "% " } })
    volume_slider:set({ slider = { percentage = volume } })
end)

local function animate_slider_width(width)
    sbar.animate("tanh", 30.0, function()
        volume_slider:set({ slider = { width = width } })
    end)
end

volume_icon:subscribe("mouse.clicked", function()
    if tonumber(volume_slider:query().slider.width) > 0 then
        animate_slider_width(0)
    else
        animate_slider_width(100)
    end
end)
