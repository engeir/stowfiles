#!/usr/bin/bash

# Changes de volume of the default sink
# Warning: This script offers no cap for volume,
# I'd advice to not go above 150% (which is the standard cap).
# You can call this script like this:
# volume.sh [up|down|mute]

function get_volume {
    pactl get-sink-volume @DEFAULT_SINK@ | awk '{printf $5}' | cut -d '%' -f 1
}

function is_mute {
    pactl get-sink-mute @DEFAULT_SINK@
}

function send_notification {
    overvolume=$(get_volume)
    [[ $overvolume -gt 100 ]] && volume=100 || volume=$overvolume

    # Set correct icon using Unicode symbols
    if [[ $volume -eq 0 ]]; then
        icon="🔇"
    elif [[ $volume -lt 35 ]]; then
        icon="🔈"
    elif [[ $volume -lt 70 ]]; then
        icon="🔉"
    else
        icon="🔊"
    fi

    # Send the notification
    dunstify "$icon Volume: $overvolume%" -h int:value:"$volume" -t 1000 --replace=555 -u normal
}

case $1 in
    up)
        swayosd-client --output-volume 5
        # # Set the volume on (if it was muted)
        # pactl set-sink-mute @DEFAULT_SINK@ 0 > /dev/null
        # # Up the volume (+ 5%)
        # curvol=`get_volume`
        # rem=$(( (curvol + 5) % 5 ))
        # inc="+$(( 5 - rem ))%"
        # pactl set-sink-volume @DEFAULT_SINK@ $inc > /dev/null
        # send_notification
        ;;
    down)
        swayosd-client --output-volume -5
        # pactl set-sink-mute @DEFAULT_SINK@ 0 > /dev/null
        # curvol=`get_volume`
        # rem=$(( (curvol - 5) % 5 ))
        # inc="-$(( 5 + rem ))%"
        # pactl set-sink-volume @DEFAULT_SINK@ $inc > /dev/null
        # send_notification
        ;;
    mute)
        # Toggle mute
        pactl set-sink-mute @DEFAULT_SINK@ toggle >/dev/null
        if [[ $(is_mute) == "Mute: yes" ]]; then
            dunstify "🔇 Volume: Muted" --replace=555 -t 1000 -u critical
        else
            send_notification
        fi
        ;;
esac
