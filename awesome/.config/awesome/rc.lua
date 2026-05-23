-- awesome rc.lua — gruvbox, mango keybindings, i3 x11 tools
-- awesome 4.3+ required
-- deps: picom, dunst, clipcat, flameshot, slock, alacritty-dropdown,
--       menu_run, pactl, brightnessctl, batsignal, feh, fcitx5,
--       nm-applet, blueman-applet, setxkbmap, xset, xsetroot

pcall(require, "luarocks.loader")

local gears         = require("gears")
local awful         = require("awful")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local naughty       = require("naughty")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")
require("awful.autofocus")

-- ============================================================
-- ERROR HANDLING
-- ============================================================

if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title  = "Startup error",
        text   = awesome.startup_errors,
    })
end
do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        if in_error then return end
        in_error = true
        naughty.notify({
            preset = naughty.config.presets.critical,
            title  = "Error",
            text   = tostring(err),
        })
        in_error = false
    end)
end

-- ============================================================
-- THEME
-- ============================================================

beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")

-- ============================================================
-- DECK LAYOUT
-- Master left (full height), slaves stacked right (same geometry,
-- focused slave rises to top — cycle with Super+Tab / Shift+Super+Tab)
-- ============================================================

local deck = {}
deck.name  = "deck"

function deck.arrange(p)
    local cls = p.clients
    if #cls == 0 then return end

    local g   = p.workarea
    local gap = p.useless_gap or 0
    local t   = p.screen and p.screen.selected_tag
    local mf  = (t and t.master_width_factor) or 0.55

    if #cls == 1 then
        p.geometries[cls[1]] = {
            x = g.x + gap, y = g.y + gap,
            width  = g.width  - 2 * gap,
            height = g.height - 2 * gap,
        }
        return
    end

    local mw = math.floor((g.width - 3 * gap) * mf)
    local sw = g.width - mw - 3 * gap

    p.geometries[cls[1]] = {
        x = g.x + gap, y = g.y + gap,
        width = mw, height = g.height - 2 * gap,
    }

    for i = 2, #cls do
        p.geometries[cls[i]] = {
            x      = g.x + mw + 2 * gap,
            y      = g.y + gap,
            width  = sw,
            height = g.height - 2 * gap,
        }
    end
end

-- ============================================================
-- LAYOUTS
-- ============================================================

awful.layout.layouts = {
    deck,                           -- master left + stacked slaves (Tab to cycle)
    awful.layout.suit.tile,         -- master left + all slaves visible
    awful.layout.suit.max,          -- monocle
    awful.layout.suit.fair,         -- grid
    awful.layout.suit.floating,
}

-- ============================================================
-- VARIABLES
-- ============================================================

local terminal = "kitty"
local modkey   = "Mod4"
local altkey   = "Mod1"

local function spawn(cmd)
    return function() awful.spawn(cmd) end
end
local function spawn_shell(cmd)
    return function() awful.spawn.with_shell(cmd) end
end

local scripts = "~/.config/awesome/scripts"

-- ============================================================
-- TAGS  (fair default, matching mango tagrule)
-- ============================================================

awful.screen.connect_for_each_screen(function(s)
    awful.tag(
        { "1", "2", "3", "4", "5", "6", "7", "8", "9" },
        s,
        awful.layout.suit.fair
    )
end)

-- ============================================================
-- BAR WIDGETS
-- ============================================================

local function shell_widget(cmd, interval, icon)
    local w = wibox.widget { widget = wibox.widget.textbox }
    local function update()
        awful.spawn.easy_async_with_shell(cmd, function(out)
            local txt = out:gsub("%s+$", ""):gsub("^%s+", "")
            w:set_markup(
                string.format('<span foreground="#D1B88E">%s %s </span>', icon, txt)
            )
        end)
    end
    update()
    gears.timer({ timeout = interval, autostart = true, callback = update })
    return w
end

-- Nerd Font codepoints (CaskaydiaMono Nerd Font)
local I = {
    timew = "\u{F017}",   -- nf-fa-clock_o
    wifi  = "\u{F1EB}",   -- nf-fa-wifi
    disk  = "\u{F0A0}",   -- nf-fa-hdd_o
    cpu   = "\u{F2DB}",   -- nf-fa-microchip
    mem   = "\u{F85A}",   -- nf-mdi-memory
    vol   = "\u{F028}",   -- nf-fa-volume_up
    bat   = "\u{F240}",   -- nf-fa-battery_full
    clock = "\u{F073}",   -- nf-fa-calendar
}

local sep = wibox.widget {
    widget = wibox.widget.textbox,
    markup = '<span foreground="#444444"> │ </span>',
}

local w_timew = shell_widget(
    "timew-i3block 2>/dev/null || echo off",
    10, I.timew)
local w_wifi  = shell_widget(
    "nmcli -t -f active,ssid dev wifi 2>/dev/null | awk -F: '/^yes/{print $2}' | head -1 || echo --",
    10, I.wifi)
local w_disk  = shell_widget(
    "df -h / | awk 'NR==2{print $4}'",
    30, I.disk)
local w_cpu   = shell_widget(
    "uptime | awk -F'load average: ' '{printf \"%.2f\", $2}'",
    5, I.cpu)
local w_mem   = shell_widget(
    "free -h | awk 'NR==2{print $3\"/\"$2}'",
    5, I.mem)
local w_vol   = shell_widget(
    "pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null | grep -oP '\\d+%' | head -1 || echo ?",
    3, I.vol)
local w_bat   = shell_widget(
    scripts .. "/battery.sh",
    30, I.bat)
local w_clock = wibox.widget {
    widget  = wibox.widget.textclock,
    format  = '<span foreground="#D1B88E">\u{F073} %a %d %b  %H:%M </span>',
    refresh = 60,
}

-- ============================================================
-- SCREEN / BAR SETUP
-- ============================================================

local taglist_buttons = gears.table.join(
    awful.button({}, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then client.focus:move_to_tag(t) end
    end),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then client.focus:toggle_tag(t) end
    end),
    awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)

awful.screen.connect_for_each_screen(function(s)
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
        awful.button({}, 1, function() awful.layout.inc(1) end),
        awful.button({}, 3, function() awful.layout.inc(-1) end),
        awful.button({}, 4, function() awful.layout.inc(1) end),
        awful.button({}, 5, function() awful.layout.inc(-1) end)
    ))

    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
    }

    s.mytasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.focused,
        style  = { bg_normal = "#201b14", fg_normal = "#D1B88E" },
        layout = { layout = wibox.layout.fixed.horizontal },
    }

    s.mywibox = awful.wibar({
        position = "top",
        screen   = s,
        height   = beautiful.wibar_height or 24,
        bg       = "#201b14",
        fg       = "#D1B88E",
    })

    local right = {
        layout = wibox.layout.fixed.horizontal,
        w_timew, sep,
        w_wifi,  sep,
        w_disk,  sep,
        w_cpu,   sep,
        w_mem,   sep,
        w_vol,   sep,
        w_bat,   sep,
        w_clock,
    }
    if s == screen.primary then
        table.insert(right, wibox.widget.systray())
    end

    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { layout = wibox.layout.fixed.horizontal, s.mytaglist, sep, s.mylayoutbox },
        s.mytasklist,
        right,
    }
end)

-- ============================================================
-- ROOT MOUSE BUTTONS
-- ============================================================

root.buttons(gears.table.join(
    awful.button({}, 4, awful.tag.viewnext),
    awful.button({}, 5, awful.tag.viewprev)
))

-- ============================================================
-- TAG NAVIGATION HELPERS
-- ============================================================

local function view_tag(n)
    return function()
        local t = awful.screen.focused().tags[n]
        if t then t:view_only() end
    end
end

local function view_toggle(n)
    return function()
        local t = awful.screen.focused().tags[n]
        if t then awful.tag.viewtoggle(t) end
    end
end

local function move_to_tag(n)
    return function()
        if client.focus then
            local t = client.focus.screen.tags[n]
            if t then client.focus:move_to_tag(t) end
        end
    end
end

local function toggle_client_tag(n)
    return function()
        if client.focus then
            local t = client.focus.screen.tags[n]
            if t then client.focus:toggle_tag(t) end
        end
    end
end

local function view_prev_nonempty()
    local s = awful.screen.focused()
    local c = s.selected_tag
    if not c then return end
    for i = c.index - 1, 1, -1 do
        if #s.tags[i]:clients() > 0 then s.tags[i]:view_only(); return end
    end
end

local function view_next_nonempty()
    local s = awful.screen.focused()
    local c = s.selected_tag
    if not c then return end
    for i = c.index + 1, #s.tags do
        if #s.tags[i]:clients() > 0 then s.tags[i]:view_only(); return end
    end
end

-- ============================================================
-- GLOBAL KEYBINDINGS
-- ============================================================

globalkeys = gears.table.join(

    -- WM
    awful.key({ modkey, "Shift" }, "r",     awesome.restart,
        { description = "restart awesome", group = "awesome" }),
    awful.key({ modkey, "Shift" }, "e",     awesome.quit,
        { description = "quit awesome", group = "awesome" }),
    awful.key({ modkey, "Shift" }, "slash", hotkeys_popup.show_help,
        { description = "keybindings", group = "awesome" }),

    -- Applications
    awful.key({ modkey },          "Return", spawn(terminal),
        { description = "terminal", group = "apps" }),
    awful.key({ modkey },          "b",      spawn("zen-browser"),
        { description = "browser", group = "apps" }),
    awful.key({ modkey },          "space",  spawn("menu_run"),
        { description = "launcher (desktop)", group = "apps" }),
    awful.key({ altkey },          "space",  spawn("menu_run -c -l 20"),
        { description = "launcher (exec)", group = "apps" }),

    -- Focus: directional (mango: Super+hjkl)
    awful.key({ modkey }, "h",
        function() awful.client.focus.bydirection("left")  end,
        { description = "focus left",  group = "focus" }),
    awful.key({ modkey }, "j",
        function() awful.client.focus.bydirection("down")  end,
        { description = "focus down",  group = "focus" }),
    awful.key({ modkey }, "k",
        function() awful.client.focus.bydirection("up")    end,
        { description = "focus up",    group = "focus" }),
    awful.key({ modkey }, "l",
        function() awful.client.focus.bydirection("right") end,
        { description = "focus right", group = "focus" }),
    awful.key({ modkey }, "Left",
        function() awful.client.focus.bydirection("left")  end),
    awful.key({ modkey }, "Down",
        function() awful.client.focus.bydirection("down")  end),
    awful.key({ modkey }, "Up",
        function() awful.client.focus.bydirection("up")    end),
    awful.key({ modkey }, "Right",
        function() awful.client.focus.bydirection("right") end),

    -- Stack cycle: Tab (mango: Super+Tab / deck slave cycling)
    awful.key({ modkey }, "Tab",
        function() awful.client.focus.byidx(1) end,
        { description = "focus next (deck cycle)", group = "focus" }),
    awful.key({ modkey, "Shift" }, "Tab",
        function() awful.client.focus.byidx(-1) end,
        { description = "focus prev (deck cycle)", group = "focus" }),

    -- Last focused (mango: Super+p)
    awful.key({ modkey }, "p",
        function()
            awful.client.focus.history.previous()
            if client.focus then client.focus:raise() end
        end,
        { description = "focus last", group = "focus" }),

    -- Tag back-and-forth (i3: mod+Tab workspace back_and_forth)
    awful.key({ modkey, "Control" }, "Tab",
        function() awful.tag.history.restore() end,
        { description = "tag back-and-forth", group = "tags" }),

    -- Swap: directional (mango: Shift+Super+hjkl)
    awful.key({ modkey, "Shift" }, "h",
        function() awful.client.swap.bydirection("left")  end,
        { description = "swap left",  group = "client" }),
    awful.key({ modkey, "Shift" }, "j",
        function() awful.client.swap.bydirection("down")  end,
        { description = "swap down",  group = "client" }),
    awful.key({ modkey, "Shift" }, "k",
        function() awful.client.swap.bydirection("up")    end,
        { description = "swap up",    group = "client" }),
    awful.key({ modkey, "Shift" }, "l",
        function() awful.client.swap.bydirection("right") end,
        { description = "swap right", group = "client" }),

    -- Promote to master (mango: Alt+s → zoom)
    awful.key({ altkey }, "s",
        function()
            if client.focus then awful.client.setmaster(client.focus) end
        end,
        { description = "promote to master", group = "layout" }),

    -- Master factor (mango: Alt+Super+h/l)
    awful.key({ modkey, altkey }, "h",
        function() awful.tag.incmwfact(-0.05) end,
        { description = "shrink master", group = "layout" }),
    awful.key({ modkey, altkey }, "l",
        function() awful.tag.incmwfact(0.05) end,
        { description = "grow master", group = "layout" }),

    -- Master count (mango: Alt+Super+k/j)
    awful.key({ modkey, altkey }, "k",
        function() awful.tag.incnmaster(1,  nil, true) end,
        { description = "inc masters", group = "layout" }),
    awful.key({ modkey, altkey }, "j",
        function() awful.tag.incnmaster(-1, nil, true) end,
        { description = "dec masters", group = "layout" }),

    -- Layout cycle (mango: Ctrl+Super+l)
    awful.key({ modkey, "Control" }, "l",
        function() awful.layout.inc(1) end,
        { description = "next layout", group = "layout" }),
    awful.key({ modkey, "Control" }, "h",
        function() awful.layout.inc(-1) end,
        { description = "prev layout", group = "layout" }),

    -- Direct layouts
    awful.key({ modkey }, "t",
        function() awful.layout.set(awful.layout.suit.tile) end,
        { description = "layout: tile", group = "layout" }),
    awful.key({ modkey }, "d",
        function() awful.layout.set(deck) end,
        { description = "layout: deck (master+stack)", group = "layout" }),
    awful.key({ modkey }, "g",
        function() awful.layout.set(awful.layout.suit.fair) end,
        { description = "layout: grid", group = "layout" }),

    -- Gaps toggle (mango: Shift+Super+u)
    awful.key({ modkey, "Shift" }, "u",
        function()
            local t = awful.screen.focused().selected_tag
            if not t then return end
            t.gap = t.gap > 0 and 0 or (beautiful.useless_gap or 5)
        end,
        { description = "toggle gaps", group = "layout" }),

    -- Gaps inc/dec (mango: Shift+Super+i/o)
    awful.key({ modkey, "Shift" }, "i",
        function()
            local t = awful.screen.focused().selected_tag
            if t then t.gap = (t.gap or 0) + 1 end
        end,
        { description = "inc gaps", group = "layout" }),
    awful.key({ modkey, "Shift" }, "o",
        function()
            local t = awful.screen.focused().selected_tag
            if t then t.gap = math.max(0, (t.gap or 0) - 1) end
        end,
        { description = "dec gaps", group = "layout" }),

    -- Bar toggle (mango: Alt+Shift+Super+b)
    awful.key({ modkey, altkey, "Shift" }, "b",
        function()
            local s = awful.screen.focused()
            s.mywibox.visible = not s.mywibox.visible
        end,
        { description = "toggle bar", group = "awesome" }),

    -- Tag: prev/next nonempty (mango: Alt+Super+i/o)
    awful.key({ modkey, altkey }, "i", view_prev_nonempty,
        { description = "prev nonempty tag", group = "tags" }),
    awful.key({ modkey, altkey }, "o", view_next_nonempty,
        { description = "next nonempty tag", group = "tags" }),

    -- Monitor focus (mango: Alt+Shift+Super+i/o)
    awful.key({ modkey, altkey, "Shift" }, "i",
        function() awful.screen.focus_relative(-1) end,
        { description = "focus prev screen", group = "screen" }),
    awful.key({ modkey, altkey, "Shift" }, "o",
        function() awful.screen.focus_relative(1) end,
        { description = "focus next screen", group = "screen" }),

    -- Restore minimized
    awful.key({ modkey, "Shift" }, "n",
        function()
            local c = awful.client.restore()
            if c then
                c:emit_signal("request::activate", "key.unminimize", { raise = true })
            end
        end,
        { description = "restore minimized", group = "client" }),

    -- Tags 1-9
    awful.key({ modkey },                     "1", view_tag(1), { description = "tag 1", group = "tags" }),
    awful.key({ modkey },                     "2", view_tag(2), { description = "tag 2", group = "tags" }),
    awful.key({ modkey },                     "3", view_tag(3), { description = "tag 3", group = "tags" }),
    awful.key({ modkey },                     "4", view_tag(4), { description = "tag 4", group = "tags" }),
    awful.key({ modkey },                     "5", view_tag(5), { description = "tag 5", group = "tags" }),
    awful.key({ modkey },                     "6", view_tag(6), { description = "tag 6", group = "tags" }),
    awful.key({ modkey },                     "7", view_tag(7), { description = "tag 7", group = "tags" }),
    awful.key({ modkey },                     "8", view_tag(8), { description = "tag 8", group = "tags" }),
    awful.key({ modkey },                     "9", view_tag(9), { description = "tag 9", group = "tags" }),

    awful.key({ modkey, "Shift" },            "1", move_to_tag(1)),
    awful.key({ modkey, "Shift" },            "2", move_to_tag(2)),
    awful.key({ modkey, "Shift" },            "3", move_to_tag(3)),
    awful.key({ modkey, "Shift" },            "4", move_to_tag(4)),
    awful.key({ modkey, "Shift" },            "5", move_to_tag(5)),
    awful.key({ modkey, "Shift" },            "6", move_to_tag(6)),
    awful.key({ modkey, "Shift" },            "7", move_to_tag(7)),
    awful.key({ modkey, "Shift" },            "8", move_to_tag(8)),
    awful.key({ modkey, "Shift" },            "9", move_to_tag(9)),

    awful.key({ modkey, "Control" },          "1", toggle_client_tag(1)),
    awful.key({ modkey, "Control" },          "2", toggle_client_tag(2)),
    awful.key({ modkey, "Control" },          "3", toggle_client_tag(3)),
    awful.key({ modkey, "Control" },          "4", toggle_client_tag(4)),
    awful.key({ modkey, "Control" },          "5", toggle_client_tag(5)),
    awful.key({ modkey, "Control" },          "6", toggle_client_tag(6)),
    awful.key({ modkey, "Control" },          "7", toggle_client_tag(7)),
    awful.key({ modkey, "Control" },          "8", toggle_client_tag(8)),
    awful.key({ modkey, "Control" },          "9", toggle_client_tag(9)),

    awful.key({ modkey, "Control", "Shift" }, "1", view_toggle(1)),
    awful.key({ modkey, "Control", "Shift" }, "2", view_toggle(2)),
    awful.key({ modkey, "Control", "Shift" }, "3", view_toggle(3)),
    awful.key({ modkey, "Control", "Shift" }, "4", view_toggle(4)),
    awful.key({ modkey, "Control", "Shift" }, "5", view_toggle(5)),
    awful.key({ modkey, "Control", "Shift" }, "6", view_toggle(6)),
    awful.key({ modkey, "Control", "Shift" }, "7", view_toggle(7)),
    awful.key({ modkey, "Control", "Shift" }, "8", view_toggle(8)),
    awful.key({ modkey, "Control", "Shift" }, "9", view_toggle(9)),

    -- --------------------------------------------------------
    -- X11 / i3 specifics
    -- --------------------------------------------------------

    -- Brightness
    awful.key({}, "XF86MonBrightnessDown",
        spawn(scripts .. "/brightness.sh down"),
        { description = "brightness down", group = "system" }),
    awful.key({}, "XF86MonBrightnessUp",
        spawn(scripts .. "/brightness.sh up"),
        { description = "brightness up", group = "system" }),
    awful.key({ altkey }, "XF86MonBrightnessDown",
        spawn(scripts .. "/brightness.sh down small")),
    awful.key({ altkey }, "XF86MonBrightnessUp",
        spawn(scripts .. "/brightness.sh up small")),

    -- Volume
    awful.key({}, "XF86AudioLowerVolume",
        spawn(scripts .. "/volume.sh down"),
        { description = "volume down", group = "system" }),
    awful.key({}, "XF86AudioRaiseVolume",
        spawn(scripts .. "/volume.sh up"),
        { description = "volume up", group = "system" }),
    awful.key({}, "XF86AudioMute",
        spawn(scripts .. "/volume.sh mute"),
        { description = "mute", group = "system" }),
    awful.key({}, "XF86AudioMicMute",
        spawn("pactl set-source-mute @DEFAULT_SOURCE@ toggle"),
        { description = "mic mute", group = "system" }),

    -- Screenshot (i3: $monster+p)
    awful.key({ modkey, altkey, "Shift", "Control" }, "p",
        spawn("flameshot gui"),
        { description = "screenshot", group = "apps" }),

    -- Lock screen (i3: mod+Shift+period)
    awful.key({ modkey, "Shift" }, "period",
        spawn("slock"),
        { description = "lock screen", group = "apps" }),

    -- Clipboard (i3: mod+Shift+g → clipcat-menu)
    awful.key({ modkey, "Shift" }, "g",
        spawn("clipcat-menu -f dmenu"),
        { description = "clipboard", group = "apps" }),

    -- Password managers
    awful.key({ modkey, "Shift" }, "p",
        spawn("bash $HOME/bin/passmenu"),
        { description = "passmenu", group = "apps" }),
    awful.key({ modkey, "Shift" }, "b",
        spawn("bash $HOME/bin/bwmenu"),
        { description = "bitwarden menu", group = "apps" }),

    -- Notifications toggle (i3: mod+Shift+Alt+p)
    awful.key({ modkey, "Shift", altkey }, "p",
        spawn("dunstctl set-paused toggle"),
        { description = "toggle notifications", group = "apps" }),

    -- Display config (i3: mod+Shift+d)
    awful.key({ modkey, "Shift" }, "d",
        spawn("displayselect"),
        { description = "display config", group = "apps" }),

    -- Dropdown launcher (i3: mod+Alt+space)
    awful.key({ modkey, altkey }, "space",
        spawn("alacritty-dropdown-launcher"),
        { description = "dropdown launcher", group = "apps" }),

    -- File/text helpers (i3: mod+Shift+Alt+f/t/u/y)
    awful.key({ modkey, "Shift", altkey }, "f", spawn("pdf_open")),
    awful.key({ modkey, "Shift", altkey }, "t", spawn("find_txt")),
    awful.key({ modkey, "Shift", altkey }, "u",
        spawn("alacritty-dropdown --font 11 clip-manage")),
    awful.key({ modkey, "Shift", altkey }, "y",
        spawn("alacritty-dropdown --font 11 pamfzf-new")),

    -- Picom opacity (i3: $monster+i/o/minus/plus)
    awful.key({ modkey, altkey, "Shift", "Control" }, "i",
        spawn_shell("bash ~/.config/picom/adjust-opacity -inactive")),
    awful.key({ modkey, altkey, "Shift", "Control" }, "o",
        spawn_shell("bash ~/.config/picom/adjust-opacity +inactive")),
    awful.key({ modkey, altkey, "Shift", "Control" }, "minus",
        spawn_shell("bash ~/.config/picom/adjust-opacity -active")),
    awful.key({ modkey, altkey, "Shift", "Control" }, "plus",
        spawn_shell("bash ~/.config/picom/adjust-opacity +active")),

    -- Monster bindings (Super+Alt+Shift+Control = i3 $monster)
    awful.key({ modkey, altkey, "Shift", "Control" }, "0",
        hotkeys_popup.show_help,
        { description = "keybindings popup", group = "awesome" }),
    awful.key({ modkey, altkey, "Shift", "Control" }, "a",
        spawn("alacritty-dropdown --font 11 rtui-dd")),
    awful.key({ modkey, altkey, "Shift", "Control" }, "b",
        spawn("snippet browse --dmenu")),
    awful.key({ modkey, altkey, "Shift", "Control" }, "c",
        spawn("alacritty-dropdown --font 11 calcure")),
    awful.key({ modkey, altkey, "Shift", "Control" }, "d",
        spawn("toggle-cursor")),
    awful.key({ modkey, altkey, "Shift", "Control" }, "e",
        spawn("send-ex-cmd")),
    awful.key({ modkey, altkey, "Shift", "Control" }, "j",
        spawn("url-shorten")),
    awful.key({ modkey, altkey, "Shift", "Control" }, "l",
        spawn("alacritty-dropdown --font 11 snippet browse")),
    awful.key({ modkey, altkey, "Shift", "Control" }, "m",
        spawn("alacritty-dropdown --font 11 pulsemixer")),
    awful.key({ modkey, altkey, "Shift", "Control" }, "r",
        spawn("alacritty-dropdown --font 11 snippet browse --search")),
    awful.key({ modkey, altkey, "Shift", "Control" }, "s",
        spawn("timew-dmenu")),
    awful.key({ modkey, altkey, "Shift", "Control" }, "t",
        spawn("find_txt nor"))
)

-- ============================================================
-- CLIENT KEYBINDINGS
-- ============================================================

clientkeys = gears.table.join(

    -- Kill (mango: Super+q)
    awful.key({ modkey }, "q",
        function(c) c:kill() end,
        { description = "close", group = "client" }),

    -- Toggle float (mango: Super+s)
    awful.key({ modkey }, "s",
        awful.client.floating.toggle,
        { description = "toggle float", group = "client" }),

    -- Toggle fullscreen (mango: Super+f)
    awful.key({ modkey }, "f",
        function(c) c.fullscreen = not c.fullscreen; c:raise() end,
        { description = "fullscreen", group = "client" }),

    -- Maximize / monocle (mango: Super+m → togglemaximizescreen)
    awful.key({ modkey }, "m",
        function(c) c.maximized = not c.maximized; c:raise() end,
        { description = "maximize", group = "client" }),

    -- Sticky / global (mango: Super+g → toggleglobal)
    awful.key({ modkey }, "g",
        function(c) c.sticky = not c.sticky end,
        { description = "toggle sticky", group = "client" }),

    -- Minimize (mango: Super+i)
    awful.key({ modkey }, "i",
        function(c) c.minimized = true end,
        { description = "minimize", group = "client" }),

    -- Move to screen: arrows (mango: Shift+Super+Up/Down/Left/Right → tagmon)
    awful.key({ modkey, "Shift" }, "Up",
        function(c) c:move_to_screen(c.screen.index - 1) end,
        { description = "move to prev screen", group = "screen" }),
    awful.key({ modkey, "Shift" }, "Down",
        function(c) c:move_to_screen(c.screen.index + 1) end,
        { description = "move to next screen", group = "screen" }),
    awful.key({ modkey, "Shift" }, "Left",
        function(c) c:move_to_screen(c.screen.index - 1) end),
    awful.key({ modkey, "Shift" }, "Right",
        function(c) c:move_to_screen(c.screen.index + 1) end),

    -- Move floating with mouse (mod+click handled in clientbuttons)
    -- Unminimize this specific client
    awful.key({ modkey }, "n",
        function(c) c.minimized = false end,
        { description = "unminimize", group = "client" })
)

root.keys(globalkeys)

-- ============================================================
-- CLIENT MOUSE BUTTONS
-- ============================================================

clientbuttons = gears.table.join(
    awful.button({}, 1,
        function(c)
            c:emit_signal("request::activate", "mouse_click", { raise = true })
        end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize)
)

-- ============================================================
-- RULES
-- ============================================================

awful.rules.rules = {
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus        = awful.client.focus.filter,
            raise        = true,
            keys         = clientkeys,
            buttons      = clientbuttons,
            screen       = awful.screen.preferred,
            placement    = awful.placement.no_overlap + awful.placement.no_offscreen,
        },
    },
    -- Float dialogs and known floating apps
    {
        rule_any = {
            class = { "Thunar", "Translate", "blueman-manager",
                      "yesplaymusic", "clash-verge" },
            name  = { "Event Tester" },
            type  = { "dialog" },
        },
        properties = { floating = true },
    },
    -- Dropdown terminal: float + sticky + centered
    {
        rule = { name = "dropdown" },
        properties = {
            floating  = true,
            sticky    = true,
            ontop     = true,
            placement = awful.placement.centered,
        },
    },
    -- Flameshot: fullscreen, no border
    {
        rule = { class = "flameshot" },
        properties = { floating = true, border_width = 0, fullscreen = true },
    },
    -- Browser → tag 4
    {
        rule_any = { class = { "firefox", "zen", "Zen", "Google-chrome",
                               "zen-beta", "Zen-beta" } },
        properties = { tag = "4", switchtotag = true },
    },
    -- Telegram → tag 5
    {
        rule = { class = "TelegramDesktop" },
        properties = { tag = "5" },
    },
    -- Signal → tag 7
    {
        rule = { class = "Signal" },
        properties = { tag = "7" },
    },
}

-- ============================================================
-- SIGNALS
-- ============================================================

client.connect_signal("manage", function(c)
    if awesome.startup
        and not c.size_hints.user_position
        and not c.size_hints.program_position then
        awful.placement.no_offscreen(c)
    end
end)

-- Sloppy focus (mango: sloppyfocus=1)
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

-- Border color + raise focused client (important for deck stacking)
client.connect_signal("focus", function(c)
    c.border_color = beautiful.border_focus
    c:raise()
end)
client.connect_signal("unfocus", function(c)
    c.border_color = beautiful.border_normal
end)

-- ============================================================
-- AUTOSTART
-- ============================================================

local function autostart(cmd)
    local name = (cmd:match("^([%S]+)") or ""):match("[^/]+$") or cmd:match("^([%S]+)") or cmd
    awful.spawn.with_shell(
        string.format("pgrep -u $USER -xf '%s' > /dev/null 2>&1 || (%s &)", name, cmd)
    )
end

autostart("picom --config ~/.config/picom/picom.conf")
autostart("dunst -conf ~/.config/dunst/dunstrc")
autostart("clipcatd")
autostart("fcitx5 --replace -d")
autostart("blueman-applet")
autostart("nm-applet")
awful.spawn.with_shell("feh --bg-fill ~/.cache/wallpaper/wallpaper.jpg")
awful.spawn.with_shell("batsignal -b")
awful.spawn.with_shell("setxkbmap -layout no,gb")
awful.spawn.with_shell("xset r rate 200 50")
awful.spawn.with_shell("xsetroot -cursor_name left_ptr")
