#!/usr/bin/env bash

# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute

function get_volume {
    amixer get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function is_mute {
    amixer get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

function send_notification {
    # volume=`get_volume`
	volume=$(pulseaudio-control output | cut -d % -f 1)
    # Send the notification
	dunstify -h string:x-canonical-private-synchronous:audio "Volume: " -h int:value:"$volume" -t 1500 --icon audio-volume-low
    # dunstify -i audio-volume-muted-blocking -t 1000 -r 2593 -u normal "    $bar"
}

case $1 in
    up)
	# Set the volume on (if it was muted)
	amixer -D pulse set Master on > /dev/null
	# Up the volume (+ 5%)
	amixer -D pulse sset Master 5%+ > /dev/null
	send_notification
	;;
    down)
	amixer -D pulse set Master on > /dev/null
	amixer -D pulse sset Master 5%- > /dev/null
	send_notification
	;;
    mute)
    	# Toggle mute
	amixer -D pulse set Master 1+ toggle > /dev/null
	if is_mute ; then
        dunstify -h string:x-canonical-private-synchronous:audio "Muted" -h int:value:"$volume" -t 1500 --icon audio-volume-muted
	    # dunstify -i audio-volume-muted -t 8 -r 2593 -u normal "Mute"
	else
	    send_notification
	fi
	;;
esac
