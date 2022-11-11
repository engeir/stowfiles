#!/bin/sh

# Create new bookmarks by placing the highlighted text in
# "$HOME/.local/bookmarks/bookmarks.md"

# TODO: check if im on linux or macos

NEW=$(xclip -o)
FILE="$HOME/.local/share/bookmarks/bookmarks.sh"

# Thanks to
# https://unix.stackexchange.com/questions/231948/grep-for-string-but-ignore-commented-out-items-with-string
if grep -q -P "^(?=[\s]*+[^#])[^#]*($NEW)" "$FILE"; then
    notify-send "Bookmarks" "I found a second version of $NEW in your bookmarks."
else
    notify-send "Bookmarks" "Adding $NEW to your bookmarks!"
    echo "$NEW">> "$FILE"
fi
