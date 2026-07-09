#!/usr/bin/env bash
#
# Bootstrap the LightDM (GTK greeter) setup on a fresh machine.
#
# Installs the Tokyonight-Dark GTK theme + Papirus icons, symlinks the tracked
# configs into /etc/lightdm, and grants the greeter (lightdm user) traverse
# access to the config + wallpaper living under $HOME.
#
# Idempotent: safe to re-run. Needs sudo (prompts as required).

set -Eeuo pipefail

# Directory this script lives in (…/dotfiles/lightdm), regardless of CWD.
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

THEME_REPO="https://github.com/Fausto-Korpsvart/Tokyo-Night-GTK-Theme.git"
THEME_NAME="Tokyonight-Dark"

log() { printf '\033[1;34m::\033[0m %s\n' "$*"; }

# --- 1. Packages -----------------------------------------------------------
log "Installing packages (lightdm, gtk greeter, icons, sass compiler)…"
sudo apt-get update -qq
sudo apt-get install -y \
  lightdm lightdm-gtk-greeter \
  papirus-icon-theme sassc git

# --- 2. Tokyonight-Dark GTK theme -----------------------------------------
if [ -d "/usr/share/themes/${THEME_NAME}" ]; then
  log "Theme ${THEME_NAME} already installed — skipping build."
else
  log "Building ${THEME_NAME} from source…"
  tmp="$(mktemp -d)"
  trap 'rm -rf "$tmp"' EXIT
  git clone --depth 1 "$THEME_REPO" "$tmp/tn"
  # -t default = blue base, -c dark, -s standard  ->  "Tokyonight-Dark"
  sudo "$tmp/tn/themes/install.sh" -c dark -t default -s standard
fi

# --- 3. Symlink configs into /etc/lightdm ---------------------------------
log "Linking config files into /etc/lightdm…"
sudo mkdir -p /etc/lightdm
for f in lightdm.conf lightdm-gtk-greeter.conf; do
  target="/etc/lightdm/$f"
  # Back up a pre-existing real file (not our symlink) once.
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    log "Backing up existing $target -> $target.bak"
    sudo mv "$target" "$target.bak"
  fi
  sudo ln -sfn "$DIR/$f" "$target"
done

# --- 4. Greeter traverse access -------------------------------------------
# The lightdm user must traverse (o+x, not read) the path to the symlinked
# greeter.conf and the wallpaper, which live under a 700 $HOME.
log "Granting greeter traverse access to \$HOME and dotfiles…"
chmod o+x "$HOME" "$(dirname "$DIR")" "$DIR"

log "Done. Restart the display manager to apply:  sudo systemctl restart lightdm"
