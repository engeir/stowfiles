#!/usr/bin/env bash
vol=$(pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null | grep -oP '\d+%' | head -1)
muted=$(pactl get-sink-mute @DEFAULT_SINK@ 2>/dev/null | awk '{print $2}')
[ "$muted" = "yes" ] && echo "muted" || echo "${vol:---}"
