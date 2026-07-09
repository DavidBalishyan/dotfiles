#!/usr/bin/env bash
#=====================================================
#  Setup for the bspwm / sxhkd / polybar desktop
#  - installs dependencies (Debian/apt)
#  - installs the JetBrainsMono Nerd Font
#  - symlinks the configs into ~/.config
#=====================================================
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

info() { printf '\033[1;34m::\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m!!\033[0m %s\n' "$*"; }
ok()   { printf '\033[1;32m✓\033[0m %s\n' "$*"; }

PACKAGES=(
  bspwm sxhkd polybar               # wm + hotkey daemon + bar
  picom feh                         # compositor + wallpaper
  rofi dunst                        # launcher + notifications/OSD
  alacritty                         # terminal
  brightnessctl                     # brightness control (+ OSD)
  pipewire wireplumber pavucontrol  # audio stack + mixer
  playerctl                         # media-key control (MPRIS)
  i3lock xss-lock                   # screen locker + idle/suspend lock
  numlockx                          # enable numlock on login
  copyq                             # clipboard history (super+shift+v)
  gammastep                         # night light
  autorandr                         # monitor hotplug profiles
  x11-xserver-utils xinput          # xrandr / xsetroot / touchpad tweaks
  fontconfig curl unzip             # font install helpers
)

install_deps() {
  if ! command -v apt-get >/dev/null; then
    warn "apt not found — install these manually with your package manager:"
    warn "  ${PACKAGES[*]}"
    return
  fi
  info "Installing packages via apt..."
  sudo apt-get update
  sudo apt-get install -y "${PACKAGES[@]}"
  ok "Packages installed."
}

install_font() {
  if fc-list 2>/dev/null | grep -qi "JetBrainsMono Nerd Font"; then
    ok "JetBrainsMono Nerd Font already present."
    return
  fi
  info "Installing JetBrainsMono Nerd Font..."
  local dir="$HOME/.local/share/fonts"
  local url="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"
  local tmp; tmp="$(mktemp -d)"
  mkdir -p "$dir"
  if command -v curl >/dev/null; then curl -fL "$url" -o "$tmp/JBM.zip"
  else wget -O "$tmp/JBM.zip" "$url"; fi
  unzip -o "$tmp/JBM.zip" -d "$dir" >/dev/null
  rm -rf "$tmp"
  fc-cache -f "$dir" >/dev/null
  ok "Font installed."
}

link() {
  local src="$DOTFILES/$1" dest="$2"
  if [[ -L "$dest" && "$(readlink -f "$dest")" == "$(readlink -f "$src")" ]]; then
    ok "$dest already linked."
    return
  fi
  if [[ -e "$dest" || -L "$dest" ]]; then
    warn "Backing up $dest -> $dest.bak"
    rm -rf "$dest.bak"
    mv "$dest" "$dest.bak"
  fi
  ln -s "$src" "$dest"
  ok "Linked $dest -> $src"
}

link_configs() {
  info "Linking configs into ~/.config..."
  mkdir -p "$HOME/.config"
  link bspwm     "$HOME/.config/bspwm"
  link sxhkd     "$HOME/.config/sxhkd"
  link polybar   "$HOME/.config/polybar"
  link picom     "$HOME/.config/picom"
  link dunst     "$HOME/.config/dunst"
  link rofi      "$HOME/.config/rofi"
  link gammastep "$HOME/.config/gammastep"
  link gtk-3.0   "$HOME/.config/gtk-3.0"
  chmod +x "$DOTFILES/bspwm/bspwmrc" \
           "$DOTFILES/bspwm/lock.sh" \
           "$DOTFILES/sxhkd/osd.sh" \
           "$DOTFILES/rofi/powermenu.sh" \
           "$DOTFILES/polybar/launch.sh" \
           "$DOTFILES/polybar/scripts/"*.sh 2>/dev/null || true
}

main() {
  install_deps
  install_font
  link_configs
  echo
  ok "Setup complete."
  info "Log into bspwm, or reload a running session with:  bspc wm -r"
}

main "$@"
