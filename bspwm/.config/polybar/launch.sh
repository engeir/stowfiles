#!/usr/bin/env bash

## Add this to your wm startup file.
if ! command -v hideIt.sh >/dev/null 2>&1; then
    notify-send "Cannot find hideIt.sh, used by polybar"
fi
if ! command -v xdo >/dev/null 2>&1; then
    notify-send "Cannot find xdo, used by polybar"
fi

# Terminate already running bar instances
killall -q polybar
pkill -f 'hideIt.sh'

# Wait until the processes have been shut down
while pgrep -u "$UID" -x polybar >/dev/null; do sleep 1; done
SOUND="$HOME/.config/polybar/modules/sound-$(hostnamectl --static).ini"
export SOUND
# For Polybar
DEFAULT_NETWORK_INTERFACE=$(ip route | grep '^default' | awk '{print $5}' | head -n1)
export DEFAULT_NETWORK_INTERFACE

# Launch Polybar
polybar top &
disown
bspc config -m eDP-1 top_padding 0
if xrandr -q | grep -q 'HDMI-1 connected'; then
    hideIt.sh -w -i 0.2 -d "top" --name "polybar-top_eDP-1" --peek 0 --region 0x0+1920+3 &
    disown
    polybar hdmi2 &
    disown
    bspc config -m HDMI-1 top_padding 0
    hideIt.sh -w -i 0.2 -d "top" --name "polybar-hdmi1_HDMI-1" --peek 0 --region 1920x0+1920+3 &
    disown
elif xrandr -q | grep -q 'HDMI-2 connected'; then
    hideIt.sh -w -i 0.2 -d "top" --name "polybar-top_eDP-1" --peek 0 --region 0x0+1920+3 &
    disown
    polybar hdmi2 &
    disown
    bspc config -m HDMI-2 top_padding 0
    hideIt.sh -w -i 0.2 -d "top" --name "polybar-hdmi2_HDMI-2" --peek 0 --region 1920x0+1920+3 &
    disown
elif xrandr -q | grep -q 'DP-2 connected'; then
    polybar usbc &
    disown
    bspc config -m DP-2 top_padding 0
    hideIt.sh -w -i 0.2 -d "top" --name "polybar-top_eDP-1" --peek 0 --region 0x360+1920+3 &
    disown
    hideIt.sh -w -i 0.2 -d "top" --name "polybar-usbc_DP-2" --peek 0 --region 1920x0+2560+3 &
    disown
else
    hideIt.sh -w -i 0.2 -d "top" --name "polybar-top_eDP-1" --peek 0 --region 0x0+1920+3 &
    disown
fi

sleep 0.5
xdo raise -N Polybar
