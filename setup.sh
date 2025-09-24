#!/usr/bin/env bash

# Colors
GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
RESET="\033[0m"

# Emacs (the worst text editor)
if command -v emacs >/dev/null 2>&1; then
    echo -e "${GREEN}Emacs is installed at:${RESET} $(command -v emacs)"
    ln -s "$(pwd)/emacs.el" "$HOME/.emacs"
    ln -s "$(pwd)/emacs.custom.el" "$HOME/.emacs.custom.el"
else
    echo -e "${RED}Emacs is not installed.${RESET}"
fi

# Vim (the best text editor)
if command -v vim >/dev/null 2>&1; then
    echo -e "${GREEN}Vim is installed at:${RESET} $(command -v vim)"
    ln -s "$(pwd)/init.vim" "$HOME/.vimrc"
else
    echo -e "${RED}Vim is not installed.${RESET}"
fi

# tmux
if command -v tmux >/dev/null 2>&1; then
    echo -e "${GREEN}tmux is installed at:${RESET} $(command -v tmux)"
    mkdir -p "$HOME/.config/tmux"
    ln -s "$(pwd)/tmux.conf" "$HOME/.config/tmux/tmux.conf"
else
    echo -e "${RED}tmux is not installed.${RESET}"
fi


# zsh
if command -v zsh >/dev/null 2>&1; then
    echo -e "${GREEN}zsh is installed at:${RESET} $(command -v zsh)"
    ln -s "$(pwd)/zshrc" "$HOME/.zshrc"
else
    echo -e "${RED}zsh is not installed.${RESET}"
fi


# Neovim (the enhaced best text editor of all time)
if command -v nvim >/dev/null 2>&1; then
    echo -e "${GREEN}nvim is installed at:${RESET} $(command -v nvim)"
    # mkdir -p "$HOME/.config/nvim"
    ln -s "$(pwd)/nvim" "$HOME/.config/nvim"
else
    echo -e "${RED}nvim is not installed.${RESET}"
fi

# Alacritty
if command -v alacritty >/dev/null 2>&1; then
    echo -e "${GREEN}alacritty is installed at:${RESET} $(command -v alacritty)"
    mkdir -p "$HOME/.config/alacritty"
    ln -s "$(pwd)/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"
else
    echo -e "${RED}alacritty is not installed.${RESET}"
fi

# Ghostty
if command -v ghostty >/dev/null 2>&1; then
    echo -e "${GREEN}ghostty is installed at:${RESET} $(command -v ghostty)"
    mkdir -p "$HOME/.config/ghostty"
    ln -s "$(pwd)/ghostty-config" "$HOME/.config/ghostty/config"
else
    echo -e "${RED}ghostty is not installed.${RESET}"
fi

echo -e "${YELLOW}Done...${RESET}"
