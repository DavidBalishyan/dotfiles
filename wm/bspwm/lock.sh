#!/usr/bin/env bash
# Tokyo Night lock screen (i3lock). Falls back gracefully if i3lock-color
# extras aren't available.
pgrep -x i3lock >/dev/null && exit 0   # don't stack lockers

exec i3lock \
    --nofork \
    --ignore-empty-password \
    --color=1a1b26
