#!/bin/sh

# Read from bookmarks file but strip all comments and empty lines
FILE="$HOME/.local/share/bookmarks/bookmarks.sh"
TRIM=$(sed 's/\s*#.*$//;/^$/d' "$FILE")
CHOSEN=$(echo "$TRIM" | dmenu -p "Choose a bookmark to delete: " -l 20)

# Exit if none chosen.
[ "$CHOSEN" = "" ] && exit

# Thanks to https://stackoverflow.com/a/2705678
ESCAPED_REPLACE=$(printf '%s\n' "$CHOSEN" | sed -e 's/[\/&]/\\&/g')
sed -i "/$ESCAPED_REPLACE/d" "$FILE"
notify-send "Bookmarks" "Deleting $CHOSEN from your bookmarks!"
