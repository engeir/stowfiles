#!/bin/bash

has() {
    if ! command -v "$1" >/dev/null 2>&1; then
        echo "$1 is not installed. Adjust $0 if you think you do not need it."
        notify-send "$1 is not installed. Adjust $0 if you think you do not need it."
        exit 1
    fi
}

set +e

# obs
has dbus-update-activation-environment
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots >/dev/null 2>&1

# monitor auto attach
has shikane
pgrep -x shikane >/dev/null 2>&1 || shikane >/dev/null 2>&1 &

# notify
has dunst
pgrep -x dunst >/dev/null || dunst -conf "$HOME/.config/dunst/dunstrc" >/dev/null 2>&1 &

# wallpaper
has swaybg
swaybg -m fill -i ~/.cache/wallpaper/wallpaper.jpg >/dev/null 2>&1 &

# top bar
has waybar
~/.config/mango/scripts/hide_waybar_mango.sh

has clipcatd
pgrep -x clipcatd || clipcatd >/dev/null 2>&1 &

# xwayland dpi scale
has xrdb
echo "Xft.dpi: 140" | xrdb -merge # DPI scaling
# xrdb merge ~/.Xresources >/dev/null 2>&1

# ime input
has fcitx5
fcitx5 --replace -d >/dev/null 2>&1 &

# bluetooth
has blueman-applet
pgrep -x blueman-applet || blueman-applet >/dev/null 2>&1 &

# network
has nm-applet
pgrep -x nm-applet || nm-applet >/dev/null 2>&1 &

# change light value and volume value by swayosd-client in keybind
has swayosd-server
pgrep -x swayosd-server || swayosd-server >/dev/null 2>&1 &
