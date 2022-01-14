#!/bin/bash

percent=$(upower -i "$(upower -e | grep 'BAT')" | grep -E "percentage" | sed -n 's/ .* \([^ ]\+\)%.*/\1/p')
if ((percent < 10)); then
    /usr/bin/notify-send -i battery-low "Low battery"
fi
