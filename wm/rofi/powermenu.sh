#!/usr/bin/env bash
# Rofi power menu - Tokyo Night. Launched from sxhkd (super+shift+e) or the
# polybar power module.
set -euo pipefail

lock=$'  Lock'
suspend=$'  Suspend'
logout=$'  Logout'
reboot=$'  Reboot'
shutdown=$'  Shutdown'

theme="$HOME/.config/rofi/themes/tokyonight.rasi"
override='window { width: 260px; } listview { lines: 5; } inputbar { children: [ "prompt" ]; }'

chosen=$(printf '%s\n' "$lock" "$suspend" "$logout" "$reboot" "$shutdown" \
    | rofi -dmenu -i -p "Power" -theme "$theme" -theme-str "$override")

case "$chosen" in
    "$lock")     ~/.config/bspwm/lock.sh ;;
    "$suspend")  ~/.config/bspwm/lock.sh & systemctl suspend ;;
    "$logout")   bspc quit ;;
    "$reboot")   systemctl reboot ;;
    "$shutdown") systemctl poweroff ;;
esac
