#!/usr/bin/env bash
#
# If the time is before some given time-of-day, check if there are any appointments in
# my calendar and send them to notify-send. Otherwise, send a notify-send message saying
# that my day is completely open.

# Default is 2400, meaning we always want a notification if the script is run without a
# specified time
CHECK_BEFORE_THIS="${1:-2400}"
NOW="$(date +%H%M)"

if [ "$CHECK_BEFORE_THIS" -lt "$NOW" ]; then
    exit 0
fi

SCHEDULE="$(calcurse -a)"
if [ "$SCHEDULE" == "" ]; then
    SCHEDULE="Today's calendar is empty space!"
    URGE="low"
else
    URGE="critical"
fi

notify-send -u "$URGE" "Today's schedule" "$SCHEDULE"
