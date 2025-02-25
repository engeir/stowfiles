#!/bin/sh
# xrdb -load $HOME/.Xresources &
# exec picom --fade-in-step=1 --fade-out-step=1 --no-fadeing-openclose &
# dunst &
xset r rate 200 70 &
exec bspwm
