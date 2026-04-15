#!/usr/bin/bash

# Wayland display selector similar to displayselect for X11
# Uses wlr-randr instead of xrandr

if ! command -v wlr-randr >/dev/null 2>&1; then
    notify-send "Please install wlr-randr to use this script ($0)"
    exit 1
fi

if ! command -v dmenu >/dev/null 2>&1; then
    notify-send "Please install dmenu to use this script ($0)"
    exit 1
fi

# dmenu options - use array to avoid quoting issues
DMENU_OPTS=(-c -l 6)

twoscreen() {
    mirror=$(printf 'no\nyes' | dmenu "${DMENU_OPTS[@]}" -p "Mirror displays?")
    if [ "$mirror" = "yes" ]; then
        external=$(echo "$screens" | dmenu "${DMENU_OPTS[@]}" -p "Optimize resolution for:")
        internal=$(echo "$screens" | grep -v "$external")

        if [ "$external" = "eDP-1" ]; then
            # Optimize for laptop screen - use laptop resolution for both
            wlr-randr --output eDP-1 --on --pos 0,0 --output "$internal" --on --pos 0,0 --scale 1
        else
            # Optimize for external - use external resolution for both
            wlr-randr --output "$external" --on --pos 0,0 --output eDP-1 --on --pos 0,0 --scale 1
        fi
    else
        primary=$(echo "$screens" | dmenu "${DMENU_OPTS[@]}" -p "Select primary display:")
        secondary=$(echo "$screens" | grep -v "^$primary$")
        direction=$(printf 'left\nright\nabove\nbelow' | dmenu "${DMENU_OPTS[@]}" -p "Position of $secondary relative to $primary:")

        case "$direction" in
            "left")
                # Secondary on left, primary on right
                wlr-randr --output "$secondary" --on --pos 0,0 --output "$primary" --on --pos 1920,0
                ;;
            "right")
                # Primary on left, secondary on right
                wlr-randr --output "$primary" --on --pos 0,0 --output "$secondary" --on --pos 1920,0
                ;;
            "above")
                # Secondary above primary
                wlr-randr --output "$secondary" --on --pos 0,0 --output "$primary" --on --pos 0,1080
                ;;
            "below")
                # Primary above secondary
                wlr-randr --output "$primary" --on --pos 0,0 --output "$secondary" --on --pos 0,1080
                ;;
        esac
    fi
}

multimon() {
    case "$(echo "$screens" | wc -l)" in
        2) twoscreen ;;
        *)
            notify-send "Multi-monitor setup with >2 displays not yet implemented"
            primary=$(echo "$screens" | dmenu "${DMENU_OPTS[@]}" -p "Select primary display:")
            wlr-randr --output "$primary" --on
            ;;
    esac
}

onescreen() {
    # Turn on selected display and turn off all others
    wlr-randr --output "$1" --on
    echo "$allposs" | grep -v "$1" | while read -r output; do
        wlr-randr --output "$output" --off
    done
}

# Get all possible displays
allposs=$(wlr-randr --json | jq -r '.[].name')

# Get all connected screens
screens=$(wlr-randr --json | jq -r '.[] | select(.modes | length > 0) | .name')

# Remove eDP-1 if the lid is closed (if lid state file exists)
if [ -f "/proc/acpi/button/lid/LID/state" ] && [ "$(cat "/proc/acpi/button/lid/LID/state" | awk '{print $2}')" = "closed" ]; then
    screens="$(echo "$screens" | grep -v eDP-1)"
fi

# If there's only one screen
if [ "$(echo "$screens" | wc -l)" -lt 2 ]; then
    onescreen "$screens"
    notify-send "💻 Only one screen detected." "Using it in its optimal settings..."
    exit
fi

# Get user choice including multi-monitor and manual selection
chosen=$(printf '%s\nmulti-monitor\nmanual selection' "$screens" | dmenu "${DMENU_OPTS[@]}" -p "Select display arrangement:") \
    && case "$chosen" in
        "manual selection")
            notify-send "Manual selection not implemented yet - use wlr-randr directly"
            ;;
        "multi-monitor") multimon ;;
        *) onescreen "$chosen" ;;
    esac
