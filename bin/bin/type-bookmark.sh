#!/bin/bash

if [[ $(uname -s) == "Darwin" ]]; then
    CHOOSER="sk"
else
    CHOOSER="dmenu -l 20"
fi

# Read from bookmarks file but strip all comments and empty lines
FILE="$HOME/.local/share/bookmarks/bookmarks.sh"
TRIM=$(sed 's/\s*#.*$//;/^$/d' "$FILE")
CHOSEN=$(echo "$TRIM" | "$CHOOSER")

# Exit if none chosen.
[ "$CHOSEN" = "" ] && exit
if [[ $(uname -s) == "Darwin" ]]; then
    echo "$CHOSEN" | pbcopy
else
    xdotool type "$CHOSEN"
fi
