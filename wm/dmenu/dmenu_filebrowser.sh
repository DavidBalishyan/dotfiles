#!/bin/sh
# File browser - fd-based recursive search, open with xdg-open
fd . "$HOME" --type f --hidden --exclude '.cache' --exclude '.local/share/Trash' \
    | dmenu -i -l 10 -p "File:" \
    | xargs -r xdg-open
