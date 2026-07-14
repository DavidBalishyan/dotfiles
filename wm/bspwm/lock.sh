#!/usr/bin/env bash
# Tokyo Night lock screen.
#
# Uses i3lock-color (https://github.com/Raymo111/i3lock-color) for the themed
# ring + clock. If only vanilla i3lock is installed it falls back to a plain
# solid-color lock so the machine still locks.

pgrep -x i3lock >/dev/null && exit 0   # don't stack lockers

# --- Tokyo Night palette (RRGGBBAA) ------------------------------------------
BG=1a1b26ff          # background
FG=c0caf5ff          # foreground / text
BLUE=7aa2f7ff        # focused / ring
CYAN=7dcfffff        # keypress highlight
GREEN=9ece6aff       # verifying
RED=f7768eff         # wrong
MAGENTA=bb9af7ff     # backspace highlight
COMMENT=565f89ff     # dim
CLEAR=00000000       # transparent

# --- Detect i3lock-color -----------------------------------------------------
# The fork's version string carries a ".c." marker and the Cassandra Fox /
# Raymond Li copyright (e.g. "2.13.c.5-..."); vanilla only credits Stapelberg.
# Some builds also literally say "color", so match any of these.
if i3lock --version 2>&1 | grep -qiE 'color|\.c\.|cassandra|raymond'; then
    HAS_COLOR=1
else
    HAS_COLOR=0
fi

# --- Plain fallback ----------------------------------------------------------
if [ "$HAS_COLOR" -eq 0 ]; then
    exec i3lock \
        --nofork \
        --ignore-empty-password \
        --color="${BG%??}"          # vanilla wants RRGGBB, strip alpha
fi

# --- Wallpaper background ------------------------------------------------------
# i3lock needs a PNG sized to the screen, so render the wallpaper (a JPG) into a
# screen-sized PNG: fill-and-crop to the primary resolution, a minimal gaussian
# blur, and a slight darken so the ring/clock/text stay legible.
WALLPAPER="$HOME/Pictures/wall.jpg"
IMG="/tmp/i3lock-bg.png"
rm -f "$IMG"
# Primary output resolution (fall back to 1920x1080 if xrandr can't tell us).
RES=$(xrandr 2>/dev/null | awk '/ connected primary/ {print $4} / connected/ && !p {print $3; p=1}' \
      | grep -oE '[0-9]+x[0-9]+' | head -1)
RES=${RES:-1920x1080}
if [ -f "$WALLPAPER" ] && command -v convert >/dev/null 2>&1; then
    convert "$WALLPAPER" \
        -resize "${RES}^" -gravity center -extent "$RES" \
        -gaussian-blur 0x8 \
        -brightness-contrast -12x0 \
        "$IMG" 2>/dev/null
fi
[ -f "$IMG" ] && BGOPT=(--image="$IMG") || BGOPT=(--color="${BG%??}")

# --- Themed i3lock-color -----------------------------------------------------
exec i3lock \
    --nofork \
    --ignore-empty-password \
    --pass-media-keys --pass-volume-keys \
    "${BGOPT[@]}" \
    \
    --indicator \
    --clock \
    --radius=110 \
    --ring-width=8 \
    \
    --inside-color="$CLEAR" \
    --ring-color="$COMMENT" \
    --line-uses-inside \
    --separator-color="$CLEAR" \
    \
    --keyhl-color="$CYAN" \
    --bshl-color="$MAGENTA" \
    \
    --insidever-color="$CLEAR" \
    --ringver-color="$GREEN" \
    --insidewrong-color="$CLEAR" \
    --ringwrong-color="$RED" \
    \
    --time-str="%H:%M" \
    --date-str="%A, %d %B" \
    --time-color="$FG" \
    --date-color="$COMMENT" \
    --time-size=32 \
    --date-size=14 \
    \
    --verif-text="verifying…" \
    --wrong-text="wrong" \
    --noinput-text="" \
    --verif-color="$GREEN" \
    --wrong-color="$RED" \
    --layout-color="$COMMENT"
