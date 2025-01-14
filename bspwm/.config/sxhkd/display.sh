#!/usr/bin/env bash

modes='primary
secondary
mirror
duplicate
extend'
selected=`echo "$modes" | rofi -dmenu -i -no-show-icons -width 1000`

case $selected in
"primary")
mons -o
~/.config/bspwm/monitor
;;
"secondary")
mons -s
~/.config/bspwm/monitor
;;
"mirror")
mons -m
~/.config/bspwm/monitor
;;
"duplicate")
mons -d
~/.config/bspwm/monitor
;;
"extend")
mons -e right
~/.config/bspwm/monitor
;;
*)
;;
esac

~/.config/bspwm/monitor &
