#!/usr/bin/bash

startd=$(pgrep waybar)

if [ -n "$startd" ]; then
	pkill waybar
else
	waybar -c ~/.config/mango/waybar/config.jsonc -s ~/.config/mango/waybar/style.css >/dev/null 2>&1 &
fi
