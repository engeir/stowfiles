#!/usr/bin/env bash

# Read from bookmarks file but strip all comments and empty lines
FILE="$HOME/.local/share/bookmarks/bookmarks.sh"

delete_linux() {
    TRIM=$(sed 's/\s*#.*$//;/^$/d' "$FILE")
    CHOSEN=$(echo "$TRIM" | dmenu -p "Choose a bookmark to delete: " -l 20)

    # Exit if none chosen.
    [ "$CHOSEN" = "" ] && exit

    # Thanks to https://stackoverflow.com/a/2705678
    ESCAPED_REPLACE=$(printf '%s\n' "$CHOSEN" | sed -e 's/[\/&]/\\&/g')
    sed -i "/$ESCAPED_REPLACE/d" "$FILE"
    notify-send "Bookmarks" "Deleting $CHOSEN from your bookmarks!"
}
delete_mac() {
    TRIM=$(gsed 's/\s*#.*$//;/^$/d' "$FILE")
    CHOSEN=$(echo "$TRIM" | sk -p "Choose a bookmark to delete: ")

    # Exit if none chosen.
    [ "$CHOSEN" = "" ] && exit

    # Thanks to https://stackoverflow.com/a/2705678
    ESCAPED_REPLACE=$(coreutils printf '%s\n' "$CHOSEN" | gsed -e 's/[\/&]/\\&/g')
    gsed -i "/$ESCAPED_REPLACE/d" "$FILE"
    osascript -e 'display notification "'"Deleting $CHOSEN from your bookmarks!"'" with title "Bookmarks"'
}
if [[ $(uname -s) == "Darwin" ]]; then
    delete_mac
else
    delete_linux
fi
