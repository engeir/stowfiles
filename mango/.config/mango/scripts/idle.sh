#!/usr/bin/bash

get_lid_state() {
    local lid_file
    for lid_file in /proc/acpi/button/lid/*/state; do
        if [[ -f $lid_file ]]; then
            if grep -q "closed" "$lid_file"; then
                echo "closed"
                return
            fi
        fi
    done
    echo "open"
}

get_monitor_info() {
    local edp_enabled
    edp_enabled=$(wlr-randr --json | jq -r '.[] | select(.name == "eDP-1") | .enabled')
    local monitor_count
    monitor_count=$(wlr-randr --json | jq 'length')
    local external_count=$((monitor_count - 1))

    echo "${monitor_count}:${external_count}:${edp_enabled}"
}

# Handle lid events
for arg in "$@"; do
    if [[ $arg == "--lid-down" ]]; then
        # Lid closed
        monitor_info=$(get_monitor_info)
        external_count=$(echo "$monitor_info" | cut -d: -f2)

        if [[ $external_count -gt 0 ]]; then
            # External monitor connected - disable laptop screen only
            wlr-randr --output eDP-1 --off
            wlr-dpms on
        else
            # No external monitor - disable laptop screen and suspend
            wlr-randr --output eDP-1 --off
            sleep 0.5
            systemctl suspend && hyprlock
        fi
        exit 0

    elif [[ $arg == "--lid-up" ]]; then
        # Lid opened - always enable laptop screen
        wlr-randr --output eDP-1 --on
        wlr-dpms on
        exit 0
    fi
done

# Called after monitor configuration changes (e.g., from shikane exec)
# Decide whether to suspend based on lid state and monitors
lid_state=$(get_lid_state)
monitor_info=$(get_monitor_info)
monitor_count=$(echo "$monitor_info" | cut -d: -f1)
external_count=$(echo "$monitor_info" | cut -d: -f2)
edp_enabled=$(echo "$monitor_info" | cut -d: -f3)

# Suspend if:
# - Lid is closed AND no external monitors
# OR
# - Only eDP-1 exists and it's disabled (old logic for compatibility)
if [[ $lid_state == "closed" ]] && [[ $external_count -eq 0 ]]; then
    # Lid closed with no external monitor - disable eDP-1 and suspend
    wlr-randr --output eDP-1 --off
    sleep 0.5
    systemctl suspend && hyprlock
elif [[ $lid_state == "closed" ]] && [[ $external_count -gt 0 ]]; then
    # Lid closed but external monitor present - just disable eDP-1
    wlr-randr --output eDP-1 --off
    wlr-dpms on
elif [[ $monitor_count -lt 2 ]] && [[ $edp_enabled != "true" ]]; then
    # Fallback: only eDP-1 exists and it's disabled - suspend
    systemctl suspend && hyprlock
else
    # Normal case - ensure displays are on
    wlr-dpms on
fi
