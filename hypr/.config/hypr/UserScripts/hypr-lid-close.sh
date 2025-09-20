#!/usr/bin/env bash
# disable internal, migrate everything to DP-1
hyprctl keyword monitor eDP-1,disable
hyprctl workspaces -j | jq -r '.[] | select(.monitor == "eDP-1") | .name' | while IFS= read -r w; do
    MONITOR="$(hyprctl monitors | grep "Monitor" | grep -v eDP-1 | awk '{print $2}')"
    hyprctl dispatch moveworkspacetomonitor "$w" "$MONITOR"
done
