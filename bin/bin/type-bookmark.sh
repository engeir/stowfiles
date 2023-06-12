#!/bin/bash

# Read from bookmarks file but strip all comments and empty lines
FILE="$HOME/.local/share/bookmarks/bookmarks.sh"

if [[ $(uname -s) == "Darwin" ]]; then
    CHOOSER="sk"
    TRIM=$(gsed 's/\s*#.*$//;/^$/d' "$FILE")
else
    CHOOSER="dmenu -l 20"
    TRIM=$(sed 's/\s*#.*$//;/^$/d' "$FILE")
fi

CHOSEN=$(echo "$TRIM" | eval "$CHOOSER")

# Exit if none chosen.
[ "$CHOSEN" = "" ] && exit
if [[ $(uname -s) == "Darwin" ]]; then
    echo "$CHOSEN" | pbcopy
else
    xdotool type "$CHOSEN"
fi
