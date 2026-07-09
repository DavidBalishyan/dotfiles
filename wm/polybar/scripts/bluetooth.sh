#!/usr/bin/env bash

display() {
  bluetoothctl show 2>/dev/null | grep -q "Powered: yes" || { echo "%{F#414868}󰂲%{F-}"; exit 0; }

  local device
  device=$(bluetoothctl devices Connected 2>/dev/null | sed -n '1s/^Device //;1s/ [^ ]* / /p' | cut -d' ' -f2-)
  if [ -n "$device" ]; then
    echo "󰂱 $device"
  else
    echo "󰂯"
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
  local powered menu choice mac

  bluetoothctl show 2>/dev/null | grep -q "Powered: yes" && powered=true || powered=false

  if [ "$powered" = false ]; then
    # Radio is off: only offer to turn it on (plus settings).
    choice=$(echo -e "󰂯 Turn Bluetooth On\n󰒓 Bluetooth Settings" \
      | rofi -dmenu -p "Bluetooth" -theme ~/.config/rofi/config.rasi)
    case "$choice" in
      "󰂯 Turn Bluetooth On") bluetoothctl power on ;;
      "󰒓 Bluetooth Settings") blueman-manager 2>/dev/null || bluetoothctl ;;
    esac
    return
  fi

  # Map each "<icon> <name>" menu entry back to its MAC so we can act on the choice.
  declare -A connected paired

  while read -r _ dmac dname; do
    [ -n "$dmac" ] && connected["$dmac"]="$dname"
  done < <(bluetoothctl devices Connected 2>/dev/null)

  while read -r _ dmac dname; do
    # Skip devices that are already connected; they get a Disconnect entry instead.
    [ -n "$dmac" ] && [ -z "${connected[$dmac]}" ] && paired["$dmac"]="$dname"
  done < <(bluetoothctl devices Paired 2>/dev/null)

  menu=""
  for mac in "${!connected[@]}"; do
    menu+="󰂱 Disconnect ${connected[$mac]}\n"
  done
  for mac in "${!paired[@]}"; do
    menu+="󰂯 Connect ${paired[$mac]}\n"
  done
  menu+="󰍉 Scan for devices\n---\n󰂲 Turn Bluetooth Off\n󰒓 Bluetooth Settings"

  choice=$(echo -e "$menu" | rofi -dmenu -p "Bluetooth" -theme ~/.config/rofi/config.rasi)

  case "$choice" in
    ""|"---")
      exit 0
      ;;
    "󰂲 Turn Bluetooth Off")
      bluetoothctl power off
      ;;
    "󰒓 Bluetooth Settings")
      blueman-manager 2>/dev/null || bluetoothctl
      ;;
    "󰍉 Scan for devices")
      # Discover nearby devices for ~8s, then re-open the menu with the new list.
      bluetoothctl --timeout 8 scan on >/dev/null 2>&1
      menu
      ;;
    "󰂱 Disconnect "*)
      for mac in "${!connected[@]}"; do
        [ "󰂱 Disconnect ${connected[$mac]}" = "$choice" ] && bluetoothctl disconnect "$mac" && break
      done
      ;;
    "󰂯 Connect "*)
      for mac in "${!paired[@]}"; do
        [ "󰂯 Connect ${paired[$mac]}" = "$choice" ] && bluetoothctl connect "$mac" && break
      done
      ;;
  esac
}

case "${1:-}" in
  toggle) toggle ;;
  menu) menu ;;
  *) display ;;
esac
