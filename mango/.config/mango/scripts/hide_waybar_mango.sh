#!/usr/bin/bash

# Check if --set flag is provided
if [ "$1" = "--set" ]; then
    # Start waybar if not already running
    if ! pgrep -x waybar >/dev/null; then
        waybar -c ~/.config/mango/waybar/config.jsonc -s ~/.config/mango/waybar/style.css >/dev/null 2>&1 &
    fi
else
    # Default behavior: toggle
    if pgrep -x waybar >/dev/null; then
        pkill waybar >/dev/null 2>&1
    else
        waybar -c ~/.config/mango/waybar/config.jsonc -s ~/.config/mango/waybar/style.css >/dev/null 2>&1 &
    fi
fi
