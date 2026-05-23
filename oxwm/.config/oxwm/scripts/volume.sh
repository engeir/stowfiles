#!/usr/bin/env bash
# X11 volume control via pactl (PipeWire compat) + dunstify
# Matches i3 config; consistent with fix-headset which also uses pactl/wpctl

case "$1" in
    up)   pactl set-sink-volume @DEFAULT_SINK@ +4% ;;
    down) pactl set-sink-volume @DEFAULT_SINK@ -4% ;;
    mute) pactl set-sink-mute   @DEFAULT_SINK@ toggle ;;
esac

vol=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+%' | head -1 | tr -d '%')
muted=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

if [ "$muted" = "yes" ]; then
    icon="" ; msg="Muted"
elif [ "$vol" -lt 33 ]; then
    icon="" ; msg="${vol}%"
elif [ "$vol" -lt 66 ]; then
    icon="" ; msg="${vol}%"
else
    icon="" ; msg="${vol}%"
fi

dunstify -a "volume" -u low \
    -h string:x-dunst-stack-tag:volume \
    -h int:value:"$vol" \
    "$icon Volume" "$msg"
