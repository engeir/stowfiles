#!/usr/bin/bash
URL=$(playerctl metadata mpris:artUrl 2>/dev/null)
[[ -z "$URL" ]] && exit 0

if [[ "$URL" == file://* ]]; then
    echo "${URL#file://}"
elif [[ "$URL" == http* ]]; then
    CACHE="/tmp/eww_art_$(echo "$URL" | md5sum | cut -d' ' -f1)"
    [[ ! -f "$CACHE" ]] && curl -s "$URL" -o "$CACHE"
    echo "$CACHE"
fi
