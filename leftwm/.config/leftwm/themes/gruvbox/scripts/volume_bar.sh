#!/usr/bin/env bash
# polybar volume widget (read-only, no notification)

vol=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+%' | head -1 | tr -d '%')
muted=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

if [ "$muted" = "yes" ]; then
    printf " Muted"
elif [ "$vol" -lt 33 ]; then
    printf " %s%%" "$vol"
elif [ "$vol" -lt 66 ]; then
    printf " %s%%" "$vol"
else
    printf " %s%%" "$vol"
fi
