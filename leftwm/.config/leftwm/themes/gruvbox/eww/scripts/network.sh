#!/usr/bin/env bash
for wf in /sys/class/net/wl*; do
    [ -f "$wf/operstate" ] && [ "$(cat "$wf/operstate")" = "up" ] || continue
    ssid=$(iwgetid -r "$(basename "$wf")" 2>/dev/null)
    echo "${ssid:-wifi}"
    exit 0
done
for ef in /sys/class/net/e*; do
    [ -f "$ef/operstate" ] && [ "$(cat "$ef/operstate")" = "up" ] || continue
    echo "eth"
    exit 0
done
echo "--"
