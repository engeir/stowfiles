local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
    height = 28,
    color = colors.bar.bg,
    border_color = colors.bar.border,
    shadow = true,
    sticky = true,
    padding_right = 4,
    padding_left = 4,
    blur_radius = 0,
    topmost = "off", -- Stays over YT if set to "window"
})
