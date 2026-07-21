#!/bin/sh
# Power menu - lock / suspend / logout / reboot / shutdown
chosen=$(printf '%s\n' "Lock" "Suspend" "Logout" "Reboot" "Shutdown" \
    | dmenu -i -l 5 -p "Power:")

case "$chosen" in
    "Lock")     ~/.config/bspwm/lock.sh ;;
    "Suspend")  ~/.config/bspwm/lock.sh & systemctl suspend ;;
    "Logout")   bspc quit ;;
    "Reboot")   systemctl reboot ;;
    "Shutdown") systemctl poweroff ;;
esac
