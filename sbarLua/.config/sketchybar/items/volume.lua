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
        string = icons.volume._100,
        width = 0,
        align = "left",
        color = colors.grey,
        font = {
            style = "Regular",
            size = 14.0,
        },
    },
    label = {
        width = 55,
        align = "left",
        font = {
            style = "Regular",
            size = 14.0,
        },
    },
})

volume_slider:subscribe("mouse.clicked", function(env)
    os.execute("osascript -e 'set volume output volume " .. env["PERCENTAGE"] .. "'")
end)

volume_slider:subscribe("volume_change", function(env)
    local volume = tonumber(env.INFO)
    local icon = icons.volume._0
    local volume_width = 55
    local volume_space = "    "
    if volume > 99 then
        icon = icons.volume._100
        volume_width = 65
        volume_space = " "
    elseif volume > 60 then
        icon = icons.volume._100
        volume_width = 65
        volume_space = "  "
    elseif volume > 30 then
        icon = icons.volume._66
        volume_width = 60
        volume_space = "  "
    elseif volume > 10 then
        icon = icons.volume._33
        volume_width = 60
        volume_space = "   "
    elseif volume > 0 then
        icon = icons.volume._10
        volume_width = 55
        volume_space = "    "
    end

    volume_icon:set({ label = {string = icon .. volume_space .. volume .. "%", width = volume_width} })
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
