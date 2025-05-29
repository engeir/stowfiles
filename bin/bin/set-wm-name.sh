#!/usr/bin/env bash
# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <window-title> <custom-wm-name>"
    exit 1
fi
# Assign arguments to variables for clarity
WINDOW_TITLE="$1"
CUSTOM_WM_NAME="$2"
# Find the window ID based on the title
WINDOW_ID=$(xdotool search --name "$WINDOW_TITLE" | head -n 1)
# Check if a window ID was found
if [ "$WINDOW_ID" = "" ]; then
    echo "No window found with title: $WINDOW_TITLE"
    exit 1
fi
# Set the custom WM_NAME
xprop -id "$WINDOW_ID" -f WM_NAME 8u -set WM_NAME "$CUSTOM_WM_NAME"
