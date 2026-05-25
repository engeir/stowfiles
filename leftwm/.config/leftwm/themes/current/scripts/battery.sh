#!/usr/bin/env bash
cap=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null || echo ?)
sta=$(cat /sys/class/power_supply/BAT0/status  2>/dev/null || echo "")

if [ "$sta" = "Charging" ]; then
    printf " +%s%%" "$cap"
else
    printf " %s%%" "$cap"
fi
