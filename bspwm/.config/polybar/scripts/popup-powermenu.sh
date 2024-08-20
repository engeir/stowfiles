#!/bin/sh

case "$1" in
    --popup)
        # yad=$(yad --width 300 --entry --undecorated --title "System Logout" --image=gnome-shutdown --text "Choose action:" --entry-text "Shutdown" "Reboot" "Logout" "Suspend")
        yad=$(printf "Power off\nReboot\nLogout\nSleep" | dmenu -i -l 10)

        case "$yad" in
            "Power off")
                poweroff
                ;;
            Reboot)
                reboot
                ;;
            Sleep)
                slock
                ;;
            Logout)
                bspc quit
                ;;
        esac
        ;;
    *)
        echo " "
        ;;
esac
