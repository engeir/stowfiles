#!/usr/bin/env bash
if pgrep -x tint2 >/dev/null; then
    pkill tint2
else
    tint2 -c "$HOME/.config/leftwm/themes/gruvbox/tint2rc" &
fi
