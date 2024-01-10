local settings = require("settings")
local colors = require("colors")

-- Equivalent to the --default domain
sbar.default({
    updates = "when_shown",
    icon = {
        font = {
            family = settings.font,
            style = "Bold",
            size = 11.0,
        },
        color = colors.white,
        padding_left = settings.paddings,
        padding_right = settings.paddings,
    },
    label = {
        font = {
            family = settings.font,
            style = "Semibold",
            size = 11.0,
        },
        color = colors.white,
        padding_left = settings.paddings,
        padding_right = settings.paddings,
    },
    background = {
        height = 20,
        corner_radius = 9,
        border_width = 1,
    },
    popup = {
        background = {
            border_width = 2,
            corner_radius = 9,
            border_color = colors.popup.border,
            color = colors.popup.bg,
            shadow = { drawing = true },
        },
        blur_radius = 10,
    },
    padding_left = 1,
    padding_right = 1,
})
