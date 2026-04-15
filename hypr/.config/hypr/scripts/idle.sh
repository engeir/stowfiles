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
    edp_enabled=$(hyprctl monitors -j | jq -r '.[] | select(.name == "eDP-1") | "true"' | head -1)
    [[ -z $edp_enabled ]] && edp_enabled="false"
    local monitor_count
    monitor_count=$(hyprctl monitors -j | jq 'length')
    local external_count=$((monitor_count - 1))

    echo "${monitor_count}:${external_count}:${edp_enabled}"
}

disable_edp() {
    hyprctl keyword monitor eDP-1,disable
}

enable_edp() {
    hyprctl keyword monitor eDP-1,preferred,auto,1
}

# Handle lid events
for arg in "$@"; do
    if [[ $arg == "--lid-down" ]]; then
        monitor_info=$(get_monitor_info)
        external_count=$(echo "$monitor_info" | cut -d: -f2)

        if [[ $external_count -gt 0 ]]; then
            # External monitor present — disable laptop screen only
            disable_edp
        else
            # No external monitor — disable screen, suspend, then lock
            disable_edp
            sleep 0.5
            systemctl suspend && hyprlock
        fi
        exit 0

    elif [[ $arg == "--lid-up" ]]; then
        enable_edp
        hyprctl dispatch dpms on
        exit 0
    fi
done

# Called without arguments (e.g. from shikane after monitor change)
# Re-evaluate whether to suspend based on current lid state and monitors
lid_state=$(get_lid_state)
monitor_info=$(get_monitor_info)
monitor_count=$(echo "$monitor_info" | cut -d: -f1)
external_count=$(echo "$monitor_info" | cut -d: -f2)
edp_enabled=$(echo "$monitor_info" | cut -d: -f3)

if [[ $lid_state == "closed" ]] && [[ $external_count -eq 0 ]]; then
    disable_edp
    sleep 0.5
    systemctl suspend && hyprlock
elif [[ $lid_state == "closed" ]] && [[ $external_count -gt 0 ]]; then
    disable_edp
elif [[ $monitor_count -lt 2 ]] && [[ $edp_enabled != "true" ]]; then
    systemctl suspend && hyprlock
else
    hyprctl dispatch dpms on
fi
