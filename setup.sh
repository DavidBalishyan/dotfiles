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

if cmd_exists nvim; then
    print_info "Neovim installed at: $(command -v nvim)"
    link_dotfile "$repo_root/nvim" "$HOME/.config/nvim"
else
    print_warn "Neovim is not installed. Skipping ~/.config/nvim"
fi

if cmd_exists alacritty; then
    print_info "Alacritty installed at: $(command -v alacritty)"
    link_dotfile "$repo_root/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"
else
    print_warn "Alacritty is not installed. Skipping ~/.config/alacritty/alacritty.toml"
fi

if cmd_exists ghostty; then
    print_info "Ghostty installed at: $(command -v ghostty)"
    link_dotfile "$repo_root/ghostty-config" "$HOME/.config/ghostty/config"
else
    print_warn "Ghostty is not installed. Skipping ~/.config/ghostty/config"
fi

if cmd_exists wezterm; then
    print_info "Wezterm installed at: $(command -v wezterm)"
    link_dotfile "$repo_root/wezterm.lua" "$HOME/.wezterm.lua"
else
    print_warn "Wezterm is not installed. Skipping ~/.wezterm.lua"
fi

if cmd_exists betterfetch; then
    print_info "betterfetch installed at: $(command -v betterfetch)"
    link_dotfile "$repo_root/betterfetch.toml" "$HOME/.config/betterfetch/config.toml"
else
    print_warn "betterfetch is not installed. Skipping ~/.config/betterfetch/config.toml"
fi

if cmd_exists conda; then
    print_info "conda installed at: $(command -v conda)"
    link_dotfile "$repo_root/condarc" "$HOME/.condarc"
else
    print_warn "conda is not installed. Skipping ~/.condarc"
fi

if cmd_exists starship; then
    print_info "starship installed at: $(command -v starship)"
    link_dotfile "$repo_root/starship.toml" "$HOME/.config/starship.toml"
else
    print_warn "starship is not installed. Skipping ~/.config/starship.toml"
fi

if cmd_exists fastfetch; then
    print_info "fastfetch installed at: $(command -v fastfetch)"
    link_dotfile "$repo_root/fastfetch.jsonc" "$HOME/.config/fastfetch/config.jsonc"
else
    print_warn "fastfetch is not installed. Skipping ~/.config/fastfetch/config.jsonc"
fi

if cmd_exists foot; then
    print_info "foot installed at: $(command -v foot)"
    link_dotfile "$repo_root/foot.ini" "$HOME/.config/foot/foot.ini"
else
    print_warn "foot is not installed. Skipping ~/.config/foot/foot.ini"
fi

if cmd_exists fish; then
    print_info "fish installed at: $(command -v fish)"
    link_dotfile "$repo_root/fish" "$HOME/.config/fish"
else
    print_warn "fish is not installed. Skipping ~/.config/fish"
fi

link_dotfile "$repo_root/xinitrc" "$HOME/.xinitrc"

print_info "Done."
