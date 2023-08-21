#!/bin/bash
#
# If the time is before noon, check if there are any appointments in my calendar and
# send them to notify-send. Otherwise, send a notify-send message saying that my day is
# completely open.

NOON="1200"
NOW="$(date +%H%M)"

if [ "$NOON" -lt "$NOW" ]; then
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
