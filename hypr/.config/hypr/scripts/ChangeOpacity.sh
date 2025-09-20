#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Script for changing blurs on the fly

notif="$HOME/.config/swaync/images"

active_op=$(hyprctl -j getoption decoration:active_opacity | jq ".float")
inactive_op=$(hyprctl -j getoption decoration:inactive_opacity | jq ".float")

if [ "$1" == "up" ]; then
    new=$(echo "$active_op" 0.05 | awk '{print $1 + $2}')
    hyprctl keyword decoration:active_opacity "$new"
    notify-send -e -u low -i "$notif/ja.png" " Active opacity: $new"
elif [ "$1" == "down" ]; then
    new=$(echo "$active_op" 0.05 | awk '{print $1 - $2}')
    hyprctl keyword decoration:active_opacity "$new"
    notify-send -e -u low -i "$notif/ja.png" " Active opacity: $new"
else
    hyprctl keyword decoration:inactive_opacity "$1"
    notify-send -e -u low -i "$notif/ja.png" " Inactive opacity: $1"
fi
