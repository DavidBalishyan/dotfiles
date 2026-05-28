#!/bin/bash

source "$(dirname "$0")/board.bash"

require_root

header "GRUB Config Generator"

prompt timeout "Enter GRUB timeout (seconds)" && TIMEOUT=${timeout:-5}

choose default_choice "Select default boot option" "First entry (0)" "Saved (last used)"
case "$default_choice" in
    "Saved (last used)") DEFAULT="saved" ;;
    *) DEFAULT="0" ;;
esac

choose style_choice "Select menu style" "Show menu" "Hidden menu"
if [ "$style_choice" == "Hidden menu" ]; then
    TIMEOUT_STYLE="hidden"
else
    TIMEOUT_STYLE="menu"
fi

prompt theme "Enter path to GRUB theme (leave empty for none)"
prompt resolution "Enter resolution (e.g. 1920x1080) (leave empty for auto)"

info "Backing up current config..."
run sudo cp /etc/default/grub /etc/default/grub.bak

info "Generating new GRUB config..."

sudo tee /etc/default/grub > /dev/null <<EOF
GRUB_DEFAULT=$DEFAULT
GRUB_TIMEOUT=$TIMEOUT
GRUB_TIMEOUT_STYLE=$TIMEOUT_STYLE
GRUB_DISTRIBUTOR=\`lsb_release -i -s 2> /dev/null || echo Debian\`
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
GRUB_CMDLINE_LINUX=""
EOF

if [ -n "$theme" ]; then
    echo "GRUB_THEME=\"$theme\"" | sudo tee -a /etc/default/grub > /dev/null
fi

if [ -n "$resolution" ]; then
    echo "GRUB_GFXMODE=$resolution" | sudo tee -a /etc/default/grub > /dev/null
fi

info "Updating GRUB..."
run sudo update-grub

ok "GRUB configuration updated successfully!"
ok "Backup saved at /etc/default/grub.bak"
