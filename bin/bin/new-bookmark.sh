#!/bin/bash

# Create new bookmarks by placing the highlighted text in
# "$HOME/.local/bookmarks/bookmarks.md"

if [[ $(uname -s) == "Darwin" ]]; then
    NEW=$(pbpaste)
    notifier() {
        osascript -e 'display notification "'"$1"'" with title "Bookmarks"'
    }
else
    NEW=$(xclip -o)
    notifier() {
        notify-send "Bookmarks" "$1"
    }
fi

FILE="$HOME/.local/share/bookmarks/bookmarks.sh"

# Thanks to https://unix.stackexchange.com/a/231959
if ggrep -q -P "^(?=[\s]*+[^#])[^#]*($NEW)" "$FILE"; then
    notifier "I found a second version of $NEW in your bookmarks."
    echo "1"
    # notify-send "Bookmarks" "I found a second version of $NEW in your bookmarks."
else
    notifier "Adding $NEW to your bookmarks!"
    echo "2"
    # notify-send "Bookmarks" "Adding $NEW to your bookmarks!"
    echo "$NEW" >>"$FILE"
fi
