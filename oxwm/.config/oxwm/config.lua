---@module 'oxwm'

-- ============================================================
-- CORE
-- ============================================================

oxwm.set_terminal("kitty")
oxwm.set_modkey("Mod4")
oxwm.set_tags({ "1", "2", "3", "4", "5", "6", "7", "8", "9" })
oxwm.set_layout("tiling")
oxwm.auto_tile(true)
oxwm.set_floating_position("center")
oxwm.tag.set_back_and_forth(true)

-- ============================================================
-- APPEARANCE  (gruvbox palette from mango config.conf)
-- ============================================================

oxwm.border.set_width(3)
oxwm.border.set_focused_color("#c9b890")   -- mango focuscolor
oxwm.border.set_unfocused_color("#444444") -- mango bordercolor

oxwm.gaps.enable()
oxwm.gaps.set_inner(5, 5)
oxwm.gaps.set_outer(5, 5)
oxwm.gaps.set_smart(true)

-- ============================================================
-- STATUS BAR
-- ============================================================

oxwm.bar.set_font("CaskaydiaMono Nerd Font:style=Bold:size=10")
oxwm.bar.set_position("top")
oxwm.bar.set_hide_vacant_tags(false)

oxwm.bar.set_scheme_normal("#D1B88E",  "#201b14", "#444444")
oxwm.bar.set_scheme_occupied("#c9b890", "#201b14", "#c9b890")
oxwm.bar.set_scheme_selected("#201b14", "#DA7510", "#DA7510")
oxwm.bar.set_scheme_urgent("#ddca9e",  "#ad401f", "#ad401f")

oxwm.bar.set_blocks({
    oxwm.bar.block.systray(),
    oxwm.bar.block.shell({
        format = "  {} ",
        command = "pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null | grep -oP '\\d+%' | head -1 || echo '?'",
        interval = 3,
        color = "#D1B88E",
        underline = false,
    }),
    oxwm.bar.block.battery({
        format = "  {} ",
        charging  = "+{}%",
        discharging = "{}%",
        full      = "FULL",
        battery_name = "BAT0",
        interval  = 30,
        color     = "#D1B88E",
        underline = false,
    }),
    oxwm.bar.block.datetime({
        format      = "  {} ",
        date_format = "%a %d %b  %H:%M",
        interval    = 60,
        color       = "#D1B88E",
        underline   = false,
    }),
})

-- ============================================================
-- KEYBINDINGS
-- ============================================================

-- Config / session
oxwm.key.bind({ "Mod4", "Shift" },           "r", oxwm.restart())
oxwm.key.bind({ "Mod4", "Shift" },           "slash", oxwm.show_keybinds())

-- Applications
oxwm.key.bind({ "Mod4" },                    "Return", oxwm.spawn_terminal())
oxwm.key.bind({ "Mod4" },                    "b",      oxwm.spawn("zen"))
oxwm.key.bind({ "Mod4" },                    "space",  oxwm.spawn("~/bin/menu_run"))
oxwm.key.bind({ "Mod1" },                    "space",  oxwm.spawn("menu_run -c -l 20"))

-- Kill
oxwm.key.bind({ "Mod4" }, "q", oxwm.client.kill())

-- Focus: hjkl + Tab
-- oxwm is stack-based; h/k = prev, l/j = next (closest to mango directional intent)
oxwm.key.bind({ "Mod4" },        "h",   oxwm.client.focus_stack(-1))
oxwm.key.bind({ "Mod4" },        "j",   oxwm.client.focus_stack(1))
oxwm.key.bind({ "Mod4" },        "k",   oxwm.client.focus_stack(-1))
oxwm.key.bind({ "Mod4" },        "l",   oxwm.client.focus_stack(1))
oxwm.key.bind({ "Mod4" },        "Tab", oxwm.client.focus_stack(1))
oxwm.key.bind({ "Mod4", "Shift" }, "Tab", oxwm.client.focus_stack(-1))

-- Swap in stack: Shift+hjkl
oxwm.key.bind({ "Mod4", "Shift" }, "h", oxwm.client.move_stack(-1))
oxwm.key.bind({ "Mod4", "Shift" }, "j", oxwm.client.move_stack(1))
oxwm.key.bind({ "Mod4", "Shift" }, "k", oxwm.client.move_stack(-1))
oxwm.key.bind({ "Mod4", "Shift" }, "l", oxwm.client.move_stack(1))

-- Master area: Alt+Super+hjkl
oxwm.key.bind({ "Mod4", "Mod1" }, "h", oxwm.set_master_factor(-5))
oxwm.key.bind({ "Mod4", "Mod1" }, "l", oxwm.set_master_factor(5))
oxwm.key.bind({ "Mod4", "Mod1" }, "k", oxwm.inc_num_master(1))
oxwm.key.bind({ "Mod4", "Mod1" }, "j", oxwm.inc_num_master(-1))

-- Zoom/promote to master (mango: Alt+s)
oxwm.key.bind({ "Mod1" }, "s", oxwm.client.move_stack(-1))

-- Window state
oxwm.key.bind({ "Mod4" }, "s", oxwm.client.toggle_floating())
oxwm.key.bind({ "Mod4" }, "f", oxwm.client.toggle_fullscreen())

-- Layout cycle (mango: Ctrl+Super+l)
oxwm.key.bind({ "Mod4", "Control" }, "l", oxwm.layout.cycle())

-- Direct layout selection
oxwm.key.bind({ "Mod4" }, "m", oxwm.layout.set("monocle"))
oxwm.key.bind({ "Mod4" }, "t", oxwm.layout.set("tiling"))
oxwm.key.bind({ "Mod4" }, "g", oxwm.layout.set("grid"))

-- Gaps toggle (mango: Shift+Super+u)
oxwm.key.bind({ "Mod4", "Shift" }, "u", oxwm.toggle_gaps())

-- Bar toggle (mango: Alt+Shift+Super+b)
oxwm.key.bind({ "Mod4", "Mod1", "Shift" }, "b", oxwm.toggle_bar())

-- Monitor focus / send window
oxwm.key.bind({ "Mod4", "Mod1", "Shift" }, "i", oxwm.monitor.focus(-1))
oxwm.key.bind({ "Mod4", "Mod1", "Shift" }, "o", oxwm.monitor.focus(1))
oxwm.key.bind({ "Mod4", "Shift" }, "Up",    oxwm.monitor.tag(-1))
oxwm.key.bind({ "Mod4", "Shift" }, "Down",  oxwm.monitor.tag(1))
oxwm.key.bind({ "Mod4", "Shift" }, "Left",  oxwm.monitor.tag(-1))
oxwm.key.bind({ "Mod4", "Shift" }, "Right", oxwm.monitor.tag(1))

-- Tag navigation (nonempty, mango: Alt+Super+i/o)
oxwm.key.bind({ "Mod4", "Mod1" }, "i", oxwm.tag.view_previous_nonempty())
oxwm.key.bind({ "Mod4", "Mod1" }, "o", oxwm.tag.view_next_nonempty())

-- Tags 1-9  (oxwm tags are 0-indexed)
for i = 1, 9 do
    oxwm.key.bind({ "Mod4" },                     tostring(i), oxwm.tag.view(i - 1))
    oxwm.key.bind({ "Mod4", "Shift" },            tostring(i), oxwm.tag.move_to(i - 1))
    oxwm.key.bind({ "Mod4", "Control" },          tostring(i), oxwm.tag.toggletag(i - 1))
    oxwm.key.bind({ "Mod4", "Control", "Shift" }, tostring(i), oxwm.tag.toggleview(i - 1))
end

-- Brightness  (X11 scripts, not swayosd)
oxwm.key.bind({},       "XF86MonBrightnessDown", oxwm.spawn("~/.config/oxwm/scripts/brightness.sh down"))
oxwm.key.bind({},       "XF86MonBrightnessUp",   oxwm.spawn("~/.config/oxwm/scripts/brightness.sh up"))
oxwm.key.bind({ "Mod1" }, "XF86MonBrightnessDown", oxwm.spawn("~/.config/oxwm/scripts/brightness.sh down small"))
oxwm.key.bind({ "Mod1" }, "XF86MonBrightnessUp",   oxwm.spawn("~/.config/oxwm/scripts/brightness.sh up small"))

-- Volume  (X11 scripts)
oxwm.key.bind({}, "XF86AudioLowerVolume", oxwm.spawn("~/.config/oxwm/scripts/volume.sh down"))
oxwm.key.bind({}, "XF86AudioRaiseVolume", oxwm.spawn("~/.config/oxwm/scripts/volume.sh up"))
oxwm.key.bind({}, "XF86AudioMute",        oxwm.spawn("~/.config/oxwm/scripts/volume.sh mute"))

-- Screenshot (matches i3: $monster+p = Mod1+Shift+Mod4+Control+p)
oxwm.key.bind({ "Mod4", "Mod1", "Shift", "Control" }, "p",
    oxwm.spawn("flameshot gui"))

-- Lock screen (matches i3: $mod+Shift+period → slock)
oxwm.key.bind({ "Mod4", "Shift" }, "period",
    oxwm.spawn("slock"))

-- Clipboard (i3: clipcat-menu -f dmenu)
oxwm.key.bind({ "Mod4", "Shift" }, "g",
    oxwm.spawn("clipcat-menu -f dmenu"))

-- Password managers
oxwm.key.bind({ "Mod4", "Shift" }, "p", oxwm.spawn("bash $HOME/bin/passmenu"))
oxwm.key.bind({ "Mod4", "Shift" }, "b", oxwm.spawn("bash $HOME/bin/bwmenu"))

-- Quit WM (i3: $mod+Shift+e)
oxwm.key.bind({ "Mod4", "Shift" }, "e", oxwm.quit())

-- Notifications pause toggle (i3: $mod+Shift+Mod1+p)
oxwm.key.bind({ "Mod4", "Shift", "Mod1" }, "p", oxwm.spawn("dunstctl set-paused toggle"))

-- Mic mute (i3: XF86AudioMicMute)
oxwm.key.bind({}, "XF86AudioMicMute", oxwm.spawn("pactl set-source-mute @DEFAULT_SOURCE@ toggle"))

-- Display select (i3: $mod+Shift+d)
oxwm.key.bind({ "Mod4", "Shift" }, "d", oxwm.spawn("displayselect"))

-- Dropdown launcher (i3: $mod+Mod1+space)
oxwm.key.bind({ "Mod4", "Mod1" }, "space", oxwm.spawn("alacritty-dropdown-launcher"))

-- File/text helpers (i3: $mod+Shift+Mod1+f/t/u/y)
oxwm.key.bind({ "Mod4", "Shift", "Mod1" }, "f", oxwm.spawn("pdf_open"))
oxwm.key.bind({ "Mod4", "Shift", "Mod1" }, "t", oxwm.spawn("find_txt"))
oxwm.key.bind({ "Mod4", "Shift", "Mod1" }, "u", oxwm.spawn("alacritty-dropdown clip-manage"))
oxwm.key.bind({ "Mod4", "Shift", "Mod1" }, "y", oxwm.spawn("alacritty-dropdown pamfzf-new"))

-- Arrow key focus (i3: $mod+arrows)
oxwm.key.bind({ "Mod4" }, "Left",  oxwm.client.focus_stack(-1))
oxwm.key.bind({ "Mod4" }, "Down",  oxwm.client.focus_stack(1))
oxwm.key.bind({ "Mod4" }, "Up",    oxwm.client.focus_stack(-1))
oxwm.key.bind({ "Mod4" }, "Right", oxwm.client.focus_stack(1))

-- $monster bindings (Mod4+Mod1+Shift+Control)
oxwm.key.bind({ "Mod4", "Mod1", "Shift", "Control" }, "0",     oxwm.spawn("alacritty-dropdown show-keymaps-i3"))
oxwm.key.bind({ "Mod4", "Mod1", "Shift", "Control" }, "a",     oxwm.spawn("alacritty-dropdown rtui-dd"))
oxwm.key.bind({ "Mod4", "Mod1", "Shift", "Control" }, "b",     oxwm.spawn("snippet browse --dmenu"))
oxwm.key.bind({ "Mod4", "Mod1", "Shift", "Control" }, "c",     oxwm.spawn("alacritty-dropdown calcure"))
oxwm.key.bind({ "Mod4", "Mod1", "Shift", "Control" }, "d",     oxwm.spawn("toggle-cursor"))
oxwm.key.bind({ "Mod4", "Mod1", "Shift", "Control" }, "e",     oxwm.spawn("send-ex-cmd"))
oxwm.key.bind({ "Mod4", "Mod1", "Shift", "Control" }, "i",     oxwm.spawn("bash ~/.config/picom/adjust-opacity -inactive"))
oxwm.key.bind({ "Mod4", "Mod1", "Shift", "Control" }, "j",     oxwm.spawn("url-shorten"))
oxwm.key.bind({ "Mod4", "Mod1", "Shift", "Control" }, "l",     oxwm.spawn("alacritty-dropdown snippet browse"))
oxwm.key.bind({ "Mod4", "Mod1", "Shift", "Control" }, "m",     oxwm.spawn("alacritty-dropdown pulsemixer"))
oxwm.key.bind({ "Mod4", "Mod1", "Shift", "Control" }, "minus", oxwm.spawn("bash ~/.config/picom/adjust-opacity -active"))
oxwm.key.bind({ "Mod4", "Mod1", "Shift", "Control" }, "o",     oxwm.spawn("bash ~/.config/picom/adjust-opacity +inactive"))
oxwm.key.bind({ "Mod4", "Mod1", "Shift", "Control" }, "plus",  oxwm.spawn("bash ~/.config/picom/adjust-opacity +active"))
oxwm.key.bind({ "Mod4", "Mod1", "Shift", "Control" }, "r",     oxwm.spawn("alacritty-dropdown snippet browse --search"))
oxwm.key.bind({ "Mod4", "Mod1", "Shift", "Control" }, "s",     oxwm.spawn("timew-dmenu"))
oxwm.key.bind({ "Mod4", "Mod1", "Shift", "Control" }, "t",     oxwm.spawn("find_txt nor"))

-- ============================================================
-- WINDOW RULES
-- ============================================================

oxwm.rule.add({ title = "dropdown",         floating = true })
oxwm.rule.add({ class = "Thunar",           floating = true })
oxwm.rule.add({ class = "Translate",        floating = true })
oxwm.rule.add({ class = "Rofi",             floating = true })
oxwm.rule.add({ class = "Google-chrome",    tag = 4 })
oxwm.rule.add({ class = "TelegramDesktop",  tag = 5 })

-- ============================================================
-- AUTOSTART
-- ============================================================

oxwm.autostart("batsignal -b")
oxwm.autostart("picom --config ~/.config/picom/picom.conf")
oxwm.autostart("dunst -conf ~/.config/dunst/dunstrc")
oxwm.autostart("feh --bg-fill ~/.cache/wallpaper/wallpaper.jpg")
oxwm.autostart("clipcatd")
oxwm.autostart("fcitx5 --replace -d")
oxwm.autostart("blueman-applet")
oxwm.autostart("nm-applet")
oxwm.autostart("setxkbmap -layout no,gb")
oxwm.autostart("xset r rate 200 50")
oxwm.autostart("xsetroot -cursor_name left_ptr")
