#!/usr/bin/env bash

display() {
  bluetoothctl show 2>/dev/null | grep -q "Powered: yes" || { echo "%{F#414868}%{F-}"; exit 0; }

  local device
  device=$(bluetoothctl devices Connected 2>/dev/null | sed -n '1s/^Device //;1s/ [^ ]* / /p' | cut -d' ' -f2-)
  if [ -n "$device" ]; then
    echo "  $device"
  else
    echo ""
  fi
}

toggle() {
  local powered
  powered=$(bluetoothctl show | grep -c "Powered: yes")
  if [ "$powered" -eq 0 ]; then
    bluetoothctl power on
  else
    bluetoothctl power off
  fi
  sleep 1
}

menu() {
  local powered device_name toggle_label toggle_cmd menu choice

  bluetoothctl show 2>/dev/null | grep -q "Powered: yes" && powered=true || powered=false

  if [ "$powered" = true ]; then
    device_name=$(bluetoothctl devices Connected 2>/dev/null | sed -n '1s/^Device //;1s/ [^ ]* / /p' | cut -d' ' -f2-)
    toggle_label="  Turn Bluetooth Off"
    toggle_cmd="bluetoothctl power off"
  else
    toggle_label="  Turn Bluetooth On"
    toggle_cmd="bluetoothctl power on"
  fi

  if [ -n "$device_name" ]; then
    menu="  Disconnect from $device_name\n---\n${toggle_label}\n  Bluetooth Settings"
  else
    menu="${toggle_label}\n  Bluetooth Settings"
  fi

  choice=$(echo -e "$menu" | rofi -dmenu -p "Bluetooth" -theme ~/.config/rofi/config.rasi)

  case "$choice" in
    "")
      exit 0
      ;;
    "  Disconnect from $device_name")
      local mac
      mac=$(bluetoothctl devices Connected | head -n1 | awk '{print $2}')
      [ -n "$mac" ] && bluetoothctl disconnect "$mac"
      ;;
    "  Turn Bluetooth Off"|"  Turn Bluetooth On")
      eval "$toggle_cmd"
      ;;
    "  Bluetooth Settings")
      blueman-manager 2>/dev/null || bluetoothctl
      ;;
  esac
}

case "${1:-}" in
  toggle) toggle ;;
  menu) menu ;;
  *) display ;;
esac
