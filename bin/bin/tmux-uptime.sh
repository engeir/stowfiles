#!/bin/sh

# Find the tmux process using grep
TMUX_PROCESS=$(ps aux | grep "[t]mux" | sed 1q)
echo "$TMUX_PROCESS"

# Extract the start time from the process information
TMUX_START_TIME=$(echo $TMUX_PROCESS | awk '{print $9}')

# Convert the tmux start time to seconds since epoch
TMUX_START_TIME_SECONDS=$(date -d "$TMUX_START_TIME" +%s)

# Get the current time in seconds since epoch
CURRENT_TIME=$(date +%s)

# Calculate the uptime
UPTIME_SECONDS=$((CURRENT_TIME - TMUX_START_TIME_SECONDS))

# Calculate hours, minutes, and seconds
UPTIME_HOURS=$((UPTIME_SECONDS / 3600))
UPTIME_MINUTES=$(( (UPTIME_SECONDS % 3600) / 60 ))
UPTIME_SECONDS=$((UPTIME_SECONDS % 60))

echo "tmux has been running for: $UPTIME_HOURS hours, $UPTIME_MINUTES minutes, $UPTIME_SECONDS seconds"
