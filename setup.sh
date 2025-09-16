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



if command -v zsh >/dev/null 2>&1; then
    echo -e "${GREEN}zsh is installed at:${RESET} $(command -v zsh)"
    ln -s "$(pwd)/zshrc" "$HOME/.zshrc"
else
    echo -e "${RED}zsh is not installed.${RESET}"
fi


echo -e "${YELLOW}Done...${RESET}"
echo -e "${BLUE}NOTE:${RESET} if you are using Neovim, also might want to try out https://github.com/DavidBalishyan/nvim"

