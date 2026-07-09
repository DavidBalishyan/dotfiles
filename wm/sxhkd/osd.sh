#!/usr/bin/env bash
# On-screen display for volume & brightness.
# Shows a dunst notification with a progress bar that replaces itself on
# every keypress (via the x-dunst-stack-tag hint), so repeated presses
# update a single popup instead of stacking.

send() {
    # $1 = stack tag   $2 = icon   $3 = summary   $4 = value (0-100)
    dunstify -a osd -u low -t 1200 \
        -h "string:x-dunst-stack-tag:$1" \
        -h "int:value:$4" \
        -i "$2" "$3"
}

case "$1" in
volume)
    raw=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
    vol=$(awk '{printf "%d", $2 * 100}' <<<"$raw")
    if grep -q MUTED <<<"$raw"; then
        send osd audio-volume-muted "Muted" 0
    else
        if   ((vol <= 33)); then icon=audio-volume-low
        elif ((vol <= 66)); then icon=audio-volume-medium
        else                     icon=audio-volume-high
        fi
        send osd "$icon" "Volume  ${vol}%" "$vol"
    fi
    ;;
brightness)
    cur=$(brightnessctl get)
    max=$(brightnessctl max)
    bri=$(( cur * 100 / max ))
    send osd display-brightness-symbolic "Brightness  ${bri}%" "$bri"
    ;;
*)
    echo "usage: $0 {volume|brightness}" >&2
    exit 1
    ;;
esac
