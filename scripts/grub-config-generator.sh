#!/bin/bash
set -e

echo "=== GRUB Config Generator ==="

# Ask for timeout
read -p "Enter GRUB timeout (seconds) [default: 5]: " TIMEOUT
TIMEOUT=${TIMEOUT:-5}

# Ask for default entry
echo "Select default boot option:"
echo "1) First entry (0)"
echo "2) Saved (last used)"
read -p "Choice [1-2]: " DEFAULT_CHOICE

case $DEFAULT_CHOICE in
    2) DEFAULT="saved" ;;
    *) DEFAULT="0" ;;
esac

# Ask for GRUB style
echo "Select menu style:"
echo "1) Show menu"
echo "2) Hidden menu"
read -p "Choice [1-2]: " STYLE_CHOICE

if [ "$STYLE_CHOICE" == "2" ]; then
    TIMEOUT_STYLE="hidden"
else
    TIMEOUT_STYLE="menu"
fi

# Ask for theme
read -p "Enter path to GRUB theme (leave empty for none): " THEME

# Ask for resolution
read -p "Enter resolution (e.g. 1920x1080) [leave empty for auto]: " RESOLUTION

# Backup existing config
echo "Backing up current config..."
sudo cp /etc/default/grub /etc/default/grub.bak

# Generate new config
echo "Generating new GRUB config..."

sudo tee /etc/default/grub > /dev/null <<EOF
GRUB_DEFAULT=$DEFAULT
GRUB_TIMEOUT=$TIMEOUT
GRUB_TIMEOUT_STYLE=$TIMEOUT_STYLE
GRUB_DISTRIBUTOR=\`lsb_release -i -s 2> /dev/null || echo Debian\`
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
GRUB_CMDLINE_LINUX=""
EOF

# Add optional theme
if [ -n "$THEME" ]; then
    echo "GRUB_THEME=\"$THEME\"" | sudo tee -a /etc/default/grub > /dev/null
fi

# Add optional resolution
if [ -n "$RESOLUTION" ]; then
    echo "GRUB_GFXMODE=$RESOLUTION" | sudo tee -a /etc/default/grub > /dev/null
fi

# Update GRUB
echo "Updating GRUB..."
sudo update-grub

echo "GRUB configuration updated successfully!"
echo "Backup saved at /etc/default/grub.bak"
