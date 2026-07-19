#!/usr/bin/env bash
#
# Bootstrap the Ly TUI display manager setup on a fresh machine.
#
# Installs ly, symlinks the tracked config into /etc/ly,
# and ensures the agetty symlink exists (Debian puts it in /usr/sbin,
# but ly's service file expects /usr/bin/agetty).
#
# Idempotent: safe to re-run. Needs sudo (prompts as required).

set -Eeuo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

log() { printf '\033[1;34m::\033[0m %s\n' "$*"; }

# --- 1. Packages -----------------------------------------------------------
log "Installing ly display manager…"
sudo apt-get update -qq
sudo apt-get install -y ly

# --- 2. agetty symlink (Debian quirk) --------------------------------------
# On Debian/Ubuntu, agetty lives in /usr/sbin but ly's systemd unit
# expects /usr/bin/agetty.
if [ ! -e /usr/bin/agetty ] && [ -e /usr/sbin/agetty ]; then
  log "Creating agetty symlink: /usr/bin/agetty -> /usr/sbin/agetty"
  sudo ln -s /usr/sbin/agetty /usr/bin/agetty
fi

# --- 3. Symlink config into /etc/ly ----------------------------------------
log "Linking config.ini into /etc/ly…"
sudo mkdir -p /etc/ly
target="/etc/ly/config.ini"
if [ -e "$target" ] && [ ! -L "$target" ]; then
  log "Backing up existing $target -> $target.bak"
  sudo mv "$target" "$target.bak"
fi
sudo ln -sfn "$DIR/config.ini" "$target"

# --- 4. Enable and start ly ------------------------------------------------
log "Enabling ly@tty2 service…"
sudo systemctl enable ly@tty2.service
sudo systemctl daemon-reload

log "Done. Start ly now with:  sudo systemctl start ly@tty2"
log "Or reboot to pick it up automatically."
