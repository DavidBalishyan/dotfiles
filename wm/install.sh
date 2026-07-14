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
  xss-lock                          # idle/suspend lock trigger (locker is i3lock-color, built from source below)
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

# i3lock-color isn't packaged for Debian, so build it from source. lock.sh
# needs it for the themed ring + clock; without it the lock falls back to a
# plain solid-color screen.
I3LOCK_COLOR_BUILD_DEPS=(
  git autoconf gcc make pkg-config
  libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev
  libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev
  libxcb-randr0-dev libxcb-image0-dev libxcb-util0-dev libxcb-xrm-dev
  libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev
)

install_i3lock_color() {
  # The fork's version carries a ".c." marker / Fox / Raymond copyright.
  if command -v i3lock >/dev/null && \
     i3lock --version 2>&1 | grep -qiE 'color|\.c\.|cassandra|raymond'; then
    ok "i3lock-color already installed."
    return
  fi
  if ! command -v apt-get >/dev/null; then
    warn "apt not found — build i3lock-color manually:"
    warn "  https://github.com/Raymo111/i3lock-color"
    return
  fi
  info "Installing i3lock-color build dependencies..."
  sudo apt-get install -y "${I3LOCK_COLOR_BUILD_DEPS[@]}"

  local src; src="$(mktemp -d /tmp/i3lock-color.XXXXXX)"
  info "Building i3lock-color in $src ..."
  git clone --depth 1 https://github.com/Raymo111/i3lock-color.git "$src"
  (
    cd "$src"
    autoreconf -fi
    mkdir -p build && cd build
    ../configure --prefix=/usr/local --sysconfdir=/etc --disable-sanitizers
    make
    sudo make install
  )
  rm -rf "$src"
  ok "i3lock-color installed ($(i3lock --version 2>&1))."
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
  install_i3lock_color
  install_font
  link_configs
  echo
  ok "Setup complete."
  info "Log into bspwm, or reload a running session with:  bspc wm -r"
}

main "$@"
