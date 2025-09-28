#!/usr/bin/env bash

# -------------------------------------------------------------------------------------------------------------------------------- 
#                                           Pluigins list
# - git, tmux (built into ohmyzsh) 
# - zsh-plugin-rust [https://github.com/betterfetch/zsh-plugin-rust] 
# - you-should-use [https://github.com/MichaelAquilina/zsh-you-should-use]
# - zsh-autosuggestions [https://github.com/zsh-users/zsh-autosuggestions]
# - zsh-syntax-highlighting [https://github.com/zsh-users/zsh-syntax-highlighting]
# --------------------------------------------------------------------------------------------------------------------------------

set -e

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

install_plugin() {
    local repo=$1
    local dest=$2

    if [ ! -d "$dest" ]; then
        echo "[*] Installing $(basename "$dest")..."
        git clone --depth=1 "$repo" "$dest"
    else
        echo "[*] $(basename "$dest") already installed, updating..."
        git -C "$dest" pull --quiet
    fi
}

main() {
    # Check if oh-my-zsh is installed
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo "Oh My Zsh not found. Please install it first."
        exit 1
    fi

    echo "[*] Installing plugins and themes..."

    # Plugins
    install_plugin "https://github.com/betterfetch/zsh-plugin-rust" \
        "$ZSH_CUSTOM/plugins/zsh-rust"
    install_plugin "https://github.com/MichaelAquilina/zsh-you-should-use.git" \
        "$ZSH_CUSTOM/plugins/you-should-use"
    install_plugin "https://github.com/zsh-users/zsh-autosuggestions.git" \
        "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
    install_plugin "https://github.com/zsh-users/zsh-syntax-highlighting.git" \
        "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

    # Theme
    install_plugin "https://github.com/romkatv/powerlevel10k.git" \
        "$ZSH_CUSTOM/themes/powerlevel10k"

}

main
