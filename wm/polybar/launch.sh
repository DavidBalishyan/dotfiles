#!/usr/bin/env bash

killall -q polybar

while pgrep -x polybar >/dev/null; do sleep 0.5; done

if type "xrandr" >/dev/null 2>&1; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar main &
  done
else
  polybar main &
fi
