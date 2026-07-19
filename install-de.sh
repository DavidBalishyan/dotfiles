#!/usr/bin/env bash
#
# Install the full desktop environment: bspwm + ly display manager.
# Runs wm/install.sh and ly/install.sh under the hood, then enables ly.
#
# Idempotent: safe to re-run. Needs sudo.

set -Eeuo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

log()  { printf '\033[1;34m::\033[0m %s\n' "$*"; }
ok()   { printf '\033[1;32m✓\033[0m %s\n' "$*"; }
fail() { printf '\033[1;31m✗\033[0m %s\n' "$*" >&2; exit 1; }

# --- 1. Window manager (bspwm, sxhkd, polybar, fonts, etc.) ----------------
log "Installing desktop environment (bspwm)…"
bash "$DOTFILES/wm/install.sh"

# --- 2. Display manager (ly) ------------------------------------------------
log "Installing ly display manager…"
bash "$DOTFILES/ly/install.sh"

# --- 3. Enable ly and start on tty2 ----------------------------------------
log "Enabling ly@tty2…"
sudo systemctl enable ly@tty2.service
sudo systemctl daemon-reload

echo
ok "Desktop environment installed."
log "Reboot or run:  sudo systemctl start ly@tty2"
