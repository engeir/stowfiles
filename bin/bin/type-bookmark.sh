#!/bin/sh

# Read from bookmarks file but strip all comments and empty lines
FILE="$HOME/.local/share/bookmarks/bookmarks.sh"
TRIM=$(sed 's/\s*#.*$//;/^$/d' "$FILE")
CHOSEN=$(echo "$TRIM" | dmenu -l 20)

# Exit if none chosen.
[ "$CHOSEN" = "" ] && exit
xdotool type "$CHOSEN"
