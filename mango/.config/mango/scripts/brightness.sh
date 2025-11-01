#!/usr/bin/bash

# Change brightness level with swayosd-client.
# You can call this script like this:
# brightness.sh [up|down] <small>

if ! command -v swayosd-client >/dev/null 2>&1; then
    echo "This script ($0) depends on the swayosd-client CLI (not installed)."
    notify-send "This script ($0) depends on the swayosd-client CLI (not installed)."
fi

function get_brightness {
    var=$(brightnessctl get)
    echo "${var##* }" | sed 's/[^0-9][^.]*//g'
}

function send_notification {
    DIR=$(dirname "$0")
    brightness=$(get_brightness)
    icon_name="${HOME}/.config/rice_assets/Icons/b.png"

    # Send the notification
    dunstify "Brightness: $brightness%" -h int:value:"$brightness" -i /usr/share/icons/Adwaita/96x96/status/display-brightness-symbolic.symbolic.png -t 1000 --replace=555 -u low
}

increment=4
if [[ $2 == "small" ]]; then
    increment=1
fi

case $1 in
    up)
        swayosd-client --brightness +"$increment"
        # brightnessctl set +4%
        # send_notification
        ;;
    down)
        swayosd-client --brightness -"$increment"
        # brightnessctl set 4%-
        # send_notification
        ;;
esac
