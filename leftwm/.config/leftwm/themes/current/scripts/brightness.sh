#!/usr/bin/env bash
# brightness control via brightnessctl + dunstify

step="4"
[ "$2" = "small" ] && step="1"

case "$1" in
    up)   brightnessctl set "${step}%+" ;;
    down) brightnessctl set "${step}%-" ;;
esac

brightness=$(brightnessctl -m | awk -F, '{ print $4 }' | tr -d '%')

dunstify -a "brightness" -u low \
    -h string:x-dunst-stack-tag:brightness \
    -h int:value:"$brightness" \
    "☀ Brightness" "${brightness}%"
