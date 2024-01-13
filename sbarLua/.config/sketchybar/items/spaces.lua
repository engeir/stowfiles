local colors = require("colors")

local function mouse_click(env)
    if env.BUTTON == "right" then
        os.execute("yabai -m space --destroy " .. env.SID .. " && sketchybar --trigger space_change")
    else
        os.execute("yabai -m space --focus " .. env.SID)
    end
end

local function space_selection(env)
    local color = env.SELECTED == "true" and colors.white or colors.bg2
    local space = assert(io.popen("echo " .. env.INFO .. " | jq -r '.space'"))
    local apps = assert(io.popen("echo " .. env.INFO .. " | jq -r '.apps | keys[]'"))
    local icon = " "
    if apps ~= "" then
        local file = assert(io.popen("~/stowfiles/sketchybar/.config/sketchybar/plugins/icon_map_fn.sh " .. apps[1]))
        icon = assert(file:read("a"))
    end
    -- local file = assert(io.popen("~/stowfiles/sketchybar/.config/sketchybar/plugins/icon_map_fn.sh " .. env.INFO))
    -- local icon = assert(file:read("a"))

    sbar.set(env.NAME, {
        icon = { highlight = env.SELECTED },
        label = { highlight = env.SELECTED },
        background = { border_color = color },
    })
end

local spaces = {}
for i = 1, 10, 1 do
    local space = sbar.add("space", {
        associated_space = i,
        icon = {
            -- font = {
            --     family = "sketchybar-app-font",
            --     style = "Normal",
            --     size = "11",
            -- },
            string = i,
            padding_left = 7,
            padding_right = 7,
            color = colors.white,
            highlight_color = colors.red,
        },
        padding_left = 2,
        padding_right = 2,
        label = {
            padding_right = 5,
            color = colors.grey,
            highlight_color = colors.white,
            font = {
                family = "sketchybar-app-font",
                style = "Regular",
                size = "11",
            },
            y_offset = -1,
            drawing = false,
        },
    })

    spaces[i] = space.name
    space:subscribe("space_change", space_selection)
    space:subscribe("mouse.clicked", mouse_click)
end

sbar.add("bracket", spaces, {
    background = { color = colors.bg1, border_color = colors.bg2 },
})

local space_creator = sbar.add("item", {
    padding_left = 10,
    padding_right = 8,
    icon = {
        string = "􀆊",
        font = {
            style = "Heavy",
            size = 11.0,
        },
    },
    label = { drawing = false },
    associated_display = "active",
})

space_creator:subscribe("mouse.clicked", function(_)
    os.execute("yabai -m space --create && sketchybar --trigger space_change")
end)
