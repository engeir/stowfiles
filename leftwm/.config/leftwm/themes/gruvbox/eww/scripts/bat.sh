#!/usr/bin/env bash
cap=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null)
sta=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null)
[ -z "$cap" ] && exit 0
[ "$sta" = "Charging" ] && echo "+${cap}%" || echo "${cap}%"
