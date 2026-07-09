#!/usr/bin/env bash
# Manual night light toggle. Uses gammastep one-shot mode so the warm
# tint stays applied after the process exits, and clears on toggle off.

STATE="${XDG_RUNTIME_DIR:-/tmp}/nightlight.on"

# Reuse the night temperature from the gammastep config as the single source.
TEMP=$(sed -n 's/^temp-night=//p' "$HOME/.config/gammastep/config.ini" 2>/dev/null)
TEMP=${TEMP:-4000}

display() {
  if [ -f "$STATE" ]; then
    echo "󰛨"
  else
    echo "%{F#414868}󰃝%{F-}"
  fi
}

toggle() {
  command -v gammastep >/dev/null || exit 0
  if [ -f "$STATE" ]; then
    gammastep -x >/dev/null 2>&1
    rm -f "$STATE"
  else
    gammastep -P -O "$TEMP" >/dev/null 2>&1
    touch "$STATE"
  fi
}

case "${1:-}" in
  toggle) toggle ;;
  *) display ;;
esac
