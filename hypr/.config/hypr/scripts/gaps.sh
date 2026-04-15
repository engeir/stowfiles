#!/usr/bin/bash
# Adjust or toggle Hyprland gaps.
# Usage: gaps.sh [up|down|toggle]

DEFAULT=5

current_in=$(hyprctl getoption general:gaps_in -j | jq .int)

case $1 in
    up)
        hyprctl keyword general:gaps_in  $((current_in + 1))
        hyprctl keyword general:gaps_out $((current_in + 1))
        ;;
    down)
        new=$(( current_in > 0 ? current_in - 1 : 0 ))
        hyprctl keyword general:gaps_in  $new
        hyprctl keyword general:gaps_out $new
        ;;
    toggle)
        if [ "$current_in" -gt 0 ]; then
            hyprctl keyword general:gaps_in  0
            hyprctl keyword general:gaps_out 0
        else
            hyprctl keyword general:gaps_in  $DEFAULT
            hyprctl keyword general:gaps_out $DEFAULT
        fi
        ;;
esac
