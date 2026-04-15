#!/bin/bash

if ! command -v sunshine >/dev/null 2>&1; then
    notify-send "The sunshine CLI is not installed (needed in $0)"
    exit 1
fi

# Find first HEADLESS-* display via Hyprland
find_headless_display() {
    hyprctl monitors -j | jq -r '.[] | select(.name | startswith("HEADLESS-")) | .name' | head -n 1
}

HEADLESS_DISPLAY=$(find_headless_display)

if [ -z "$HEADLESS_DISPLAY" ]; then
    hyprctl output create headless
    notify-send "Creating virtual monitor"
    HEADLESS_DISPLAY=$(find_headless_display)
    notify-send "Starting sunshine"
    sunshine &
    notify-send "Sunshine on"
    exit 0
fi

# Toggle based on current enabled state
enabled=$(hyprctl monitors -j | jq --arg name "$HEADLESS_DISPLAY" '.[] | select(.name == $name) | "true"' | head -1)
if [ -n "$enabled" ]; then
    hyprctl keyword monitor "$HEADLESS_DISPLAY",disable
    pkill sunshine
    notify-send "Sunshine off"
    hyprctl output remove "$HEADLESS_DISPLAY"
    notify-send "Removed virtual monitor"
else
    hyprctl keyword monitor "$HEADLESS_DISPLAY",1920x1080@60,auto,1
    sunshine &
    notify-send "Sunshine on"
fi
