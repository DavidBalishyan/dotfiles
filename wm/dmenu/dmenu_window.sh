#!/bin/sh
# Window switcher - list open windows, focus selected one
selected=$(
    bspc query -N -n .window | while read -r wid; do
        name=$(xprop -id "$wid" _NET_WM_NAME 2>/dev/null | sed 's/.* = "\([^"]*\)".*/\1/')
        [ -n "$name" ] && printf '%s\n' "$wid $name"
    done | dmenu -i -l 10 -p "Window:" | awk '{print $1}'
)

[ -n "$selected" ] && bspc node -f "$selected"
