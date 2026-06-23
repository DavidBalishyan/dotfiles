#!/usr/bin/env bash

display() {
  local ssid
  ssid=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
  if [ -n "$ssid" ]; then
    echo "  $ssid"
  else
    echo "  disconnected"
  fi
}

menu() {
  local connected_ssid wifi_status toggle_label toggle_cmd networks choice

  connected_ssid=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
  wifi_status=$(nmcli radio wifi)

  if [ "$wifi_status" = "enabled" ]; then
    toggle_label="  Turn Wi-Fi Off"
    toggle_cmd="nmcli radio wifi off"
  else
    toggle_label="  Turn Wi-Fi On"
    toggle_cmd="nmcli radio wifi on"
  fi

  networks=$(nmcli -t -f ssid,signal,bars dev wifi list --rescan no 2>/dev/null | awk -F: '!seen[$1]++ && $1 != "" {printf "  %s  [%s%%]\n", $1, $2}')

  if [ -n "$connected_ssid" ]; then
    menu="  Disconnect from $connected_ssid\n${networks}\n---\n${toggle_label}\n  Network Settings"
  else
    menu="${networks}\n---\n${toggle_label}\n  Network Settings"
  fi

  choice=$(echo -e "$menu" | rofi -dmenu -p "Network" -theme ~/.config/rofi/config.rasi)

  case "$choice" in
    "")
      exit 0
      ;;
    "  Disconnect from $connected_ssid")
      nmcli connection down "$connected_ssid" 2>/dev/null || nmcli dev disconnect wlan0
      ;;
    "  Turn Wi-Fi Off"|"  Turn Wi-Fi On")
      eval "$toggle_cmd"
      ;;
    "  Network Settings")
      nm-connection-editor
      ;;
    *)
      ssid=$(echo "$choice" | sed 's/^  //; s/  \[.*\]$//')
      if [ -n "$ssid" ]; then
        nmcli dev wifi connect "$ssid" 2>/dev/null || {
          password=$(rofi -dmenu -p "Password for $ssid" -password -theme ~/.config/rofi/config.rasi)
          [ -n "$password" ] && nmcli dev wifi connect "$ssid" password "$password"
        }
      fi
      ;;
  esac
}

case "${1:-}" in
  menu) menu ;;
  *) display ;;
esac
