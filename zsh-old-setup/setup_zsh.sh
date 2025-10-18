#!/usr/bin/env bash

set -e

detect_package_manager() {
    if command -v apt >/dev/null 2>&1; then
        echo "apt"
    elif command -v dnf >/dev/null 2>&1; then
        echo "dnf"
    elif command -v yum >/dev/null 2>&1; then
        echo "yum"
    elif command -v pacman >/dev/null 2>&1; then
        echo "pacman"
    elif command -v zypper >/dev/null 2>&1; then
        echo "zypper"
    elif command -v apk >/dev/null 2>&1; then
        echo "apk"
    else
        echo "unknown"
    fi
}

install_zsh() {
    pm=$1
    echo "[*] Installing Zsh with $pm..."
    case "$pm" in
        apt) sudo apt update && sudo apt install -y zsh ;;
        dnf) sudo dnf install -y zsh ;;
        yum) sudo yum install -y zsh ;;
        pacman) sudo pacman -Sy --noconfirm zsh ;;
        zypper) sudo zypper install -y zsh ;;
        apk) sudo apk add zsh ;;
        *) echo "Unsupported package manager. Install Zsh manually."; exit 1 ;;
    esac
}

install_ohmyzsh() {
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo "[*] Installing Oh My Zsh..."
        RUNZSH=no  
		CHSH=no
		export RUNZSH CHSH
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    else
        echo "[*] Oh My Zsh is already installed."
    fi
}

change_default_shell() {
    if [ "$SHELL" != "$(command -v zsh)" ]; then
        echo "[*] Changing default shell to Zsh..."
        chsh -s "$(command -v zsh)"
        echo "Default shell changed. Please log out and log back in."
    else
        echo "Zsh is already the default shell."
    fi
}

main() {
    pm=$(detect_package_manager)
    echo "[*] Detected package manager: $pm"

    if ! command -v zsh >/dev/null 2>&1; then
        install_zsh "$pm"
    else
        echo "[*] Zsh already installed."
    fi

    install_ohmyzsh
    change_default_shell
		echo "Done... Now you can symlink the config file"
}

main 