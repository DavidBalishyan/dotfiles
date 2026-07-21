#!/bin/sh
# Raw command runner - pipe $PATH binaries into dmenu
exec printf '%s\n' $(echo "$PATH" | tr ':' '\n' | xargs -I{} find {} -maxdepth 1 -type f -executable 2>/dev/null | sort -u) \
    | dmenu -i -l 10 -p "Execute:" \
    | xargs -r -I{} sh -c 'setsid {} &>/dev/null &'
