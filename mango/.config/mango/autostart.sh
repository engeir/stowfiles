#!/bin/bash
# Autostart script for reference only

has() {
    if ! command -v "$1" >/dev/null 2>&1; then
        echo "$1 is not installed. Adjust $0 if you think you do not need it."
        notify-send "$1 is not installed. Adjust $0 if you think you do not need it."
        exit 1
    fi
}

set +e

has dbus-update-activation-environment
has dunst
# has wlsunset
has swaybg
has waybar
has clipcatd
has xrdb
has fcitx5
# has wl-clip-persist
has blueman-applet
has nm-applet
# has /usr/lib/xfce-polkit/xfce-polkit
# has sway-audio-idle-inhibit
has swayosd-server

# obs
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots >/dev/null 2>&1

# notify
dunst -conf "$HOME/.config/dunst/dunstrc"

# night light
# wlsunset -T 3501 -t 3500 >/dev/null 2>&1 &

# wallpaper
swaybg -i ~/.cache/wallpaper/wallpaper.jpg >/dev/null 2>&1 &

# top bar
waybar -c ~/.config/mango/waybar/config.jsonc -s ~/.config/mango/waybar/style.css >/dev/null 2>&1 &

clipcatd >/dev/null 2>&1 &

# xwayland dpi scale
echo "Xft.dpi: 140" | xrdb -merge # DPI scaling
# xrdb merge ~/.Xresources >/dev/null 2>&1

# ime input
fcitx5 --replace -d >/dev/null 2>&1 &

# keep clipboard content
# wl-clip-persist --clipboard regular --reconnect-tries 0 >/dev/null 2>&1 &

# clipboard content manager
wl-paste --type text --watch cliphist store >/dev/null 2>&1 &

# bluetooth
blueman-applet >/dev/null 2>&1 &

# network
nm-applet >/dev/null 2>&1 &

# Permission authentication
# /usr/lib/xfce-polkit/xfce-polkit >/dev/null 2>&1 &

# inhibit by audio
# sway-audio-idle-inhibit >/dev/null 2>&1 &

# change light value and volume value by swayosd-client in keybind
swayosd-server >/dev/null 2>&1 &
