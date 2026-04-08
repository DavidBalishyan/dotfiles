#!/usr/bin/env bash
set -euo pipefail

# Colors
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
RED="\033[0;31m"
RESET="\033[0m"

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

print_info() {
    printf "%b %s\n" "${GREEN}•${RESET}" "$1"
}

print_warn() {
    printf "%b %s\n" "${YELLOW}!${RESET}" "$1"
}

print_error() {
    printf "%b %s\n" "${RED}x${RESET}" "$1"
}

cmd_exists() {
    command -v "$1" >/dev/null 2>&1
}

backup_path() {
    printf "%s.bak.%s" "$1" "$(date +%Y%m%d%H%M%S)"
}

ensure_parent() {
    local target="$1"
    mkdir -p "$(dirname "$target")"
}

link_dotfile() {
    local source="$1"
    local target="$2"

    ensure_parent "$target"

    if [ -L "$target" ]; then
        local current
        current="$(readlink "$target")"
        if [ "$current" = "$source" ]; then
            print_info "Already linked: $target"
            return
        fi
        mv "$target" "$(backup_path "$target")"
        print_warn "Backed up existing symlink: $target"
    elif [ -e "$target" ]; then
        mv "$target" "$(backup_path "$target")"
        print_warn "Backed up existing file: $target"
    fi

    ln -s "$source" "$target"
    print_info "Linked: $target -> $source"
}

link_if_installed() {
    local command_name="$1"
    local source="$2"
    local target="$3"
    local description="$4"

    if cmd_exists "$command_name"; then
        print_info "$description installed at: $(command -v "$command_name")"
        link_dotfile "$source" "$target"
    else
        print_warn "$description is not installed. Skipping $target"
    fi
}

print_info "Starting dotfiles setup in $repo_root"

link_if_installed emacs "$repo_root/emacs.el" "$HOME/.emacs" "Emacs"
link_if_installed emacs "$repo_root/emacs.custom.el" "$HOME/.emacs.custom.el" "Emacs"
link_if_installed vim "$repo_root/init.vim" "$HOME/.vimrc" "Vim"
link_if_installed tmux "$repo_root/tmux.conf" "$HOME/.tmux.conf" "tmux"
link_if_installed zsh "$repo_root/zshrc" "$HOME/.zshrc" "zsh"
link_if_installed nvim "$repo_root/nvim" "$HOME/.config/nvim" "Neovim"
link_if_installed alacritty "$repo_root/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml" "Alacritty"
link_if_installed ghostty "$repo_root/ghostty-config" "$HOME/.config/ghostty/config" "Ghostty"
link_if_installed wezterm "$repo_root/wezterm.lua" "$HOME/.wezterm.lua" "Wezterm"
link_if_installed betterfetch "$repo_root/betterfetch.toml" "$HOME/.config/betterfetch/config.toml" "betterfetch"
link_if_installed conda "$repo_root/condarc" "$HOME/.condarc" "conda"
link_if_installed starship "$repo_root/starship.toml" "$HOME/.config/starship.toml" "starship"
link_if_installed fastfetch "$repo_root/fastfetch.jsonc" "$HOME/.config/fastfetch/config.jsonc" "fastfetch"
link_if_installed foot "$repo_root/foot.ini" "$HOME/.config/foot/foot.ini" "foot"
link_if_installed fish "$repo_root/fish" "$HOME/.config/fish" "fish"

# Xinitrc is a special case since it's only relevant if the user is running Xorg
if [ -n "$DISPLAY" ] && [ -x "$(command -v startx)" ]; then
    link_dotfile "$repo_root/xinitrc" "$HOME/.xinitrc"
else
    print_warn "Xorg does not seem to be in use. Skipping $HOME/.xinitrc"
fi 
print_info "Done."
