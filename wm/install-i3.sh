#!/usr/bin/env bash
#=====================================================
#  Setup for the i3 / polybar desktop
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
  i3                              # window manager
  polybar                         # status bar
  picom feh                       # compositor + wallpaper
  rofi dunst                      # launcher + notifications/OSD
  brightnessctl                   # brightness control (+ OSD; terminal is st, built from source below)
  pipewire wireplumber pavucontrol  # audio stack + mixer
  playerctl                       # media-key control (MPRIS)
  xss-lock                        # idle/suspend lock trigger
  i3lock                          # screen locker
  numlockx                        # enable numlock on login
  copyq                           # clipboard history (super+shift+v)
  gammastep                       # night light
  autorandr                       # monitor hotplug profiles
  x11-xserver-utils xinput        # xrandr / xsetroot / touchpad tweaks
  fontconfig curl unzip           # font install helpers
  i3-gaps                         # gaps support (overrides i3 if installed)
)

install_deps() {
  if ! command -v apt-get >/dev/null; then
    warn "apt not found - install these manually with your package manager:"
    warn "  ${PACKAGES[*]}"
    return
  fi
  info "Installing packages via apt..."
  sudo apt-get update
  sudo apt-get install -y "${PACKAGES[@]}"
  ok "Packages installed."
}

# st is my own build (https://github.com/DavidBalishyan/st.git), not packaged,
# so build it from source. It carries the scrollback, ligatures, boxdraw, alpha,
# undercurl, font2 and anysize patches and is themed to match the rest of this
# setup (Tokyo Night + JetBrainsMono Nerd Font).
ST_REPO="https://github.com/DavidBalishyan/st.git"
ST_BUILD_DEPS=(
  git build-essential pkg-config
  libx11-dev libxft-dev libfontconfig1-dev libfreetype6-dev libharfbuzz-dev
  ncurses-bin
)

install_st() {
  if command -v st >/dev/null 2>&1; then
    ok "st already installed."
    return
  fi
  if ! command -v apt-get >/dev/null; then
    warn "apt not found — build st manually from:"
    warn "  $ST_REPO"
    return
  fi
  info "Installing st build dependencies..."
  sudo apt-get install -y "${ST_BUILD_DEPS[@]}"

  local src; src="$(mktemp -d /tmp/st.XXXXXX)"
  info "Building st in $src ..."
  git clone --depth 1 "$ST_REPO" "$src"
  (
    cd "$src"
    make
    sudo make install
  )
  rm -rf "$src"
  ok "st installed."
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
  link i3       "$HOME/.config/i3"
  link polybar   "$HOME/.config/polybar"
  link picom     "$HOME/.config/picom"
  link dunst     "$HOME/.config/dunst"
  link rofi      "$HOME/.config/rofi"
  link gammastep "$HOME/.config/gammastep"
  link gtk-3.0   "$HOME/.config/gtk-3.0"
  chmod +x "$DOTFILES/polybar/launch.sh" \
           "$DOTFILES/polybar/scripts/"*.sh 2>/dev/null || true
}

main() {
  install_deps
  install_st
  install_font
  link_configs
  echo
  ok "Setup complete."
  info "Log into i3, or reload a running session with:  i3-msg reload"
}

main "$@"
