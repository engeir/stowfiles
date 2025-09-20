#!/usr/bin/env bash

SELECTION="$(printf "Closed\nOpened" | mew -p "The laptop lid should be:" -l 2)"

case "$SELECTION" in
    Closed)
        "$HOME"/.config/hypr/UserScripts/hypr-lid-close.sh
        ;;
    Opened)
        "$HOME"/.config/hypr/UserScripts/hypr-lid-open.sh
        ;;
    *) exit 0 ;;
esac
