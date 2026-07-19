#!/usr/bin/env bash

killall -q polybar

while pgrep -x polybar >/dev/null; do sleep 0.5; done

# Pick config based on the running WM
if pgrep -x i3 >/dev/null; then
  CONFIG="$HOME/.config/polybar/config-i3.ini"
else
  CONFIG="$HOME/.config/polybar/config-bspwm.ini"
fi

if type "xrandr" >/dev/null 2>&1; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar -c "$CONFIG" main &
  done
else
  polybar -c "$CONFIG" main &
fi
