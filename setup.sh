#!/usr/bin/env bash

# Colors
GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[1;33m"
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
    ln -s "$(pwd)/tmux.conf" "$HOME/.tmux.conf"
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
    mkdir -p "$HOME/.config/nvim"
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

# Wezterm
if command -v wezterm >/dev/null 2>&1; then
    echo -e "${GREEN}wezterm is installed at:${RESET} $(command -v wezterm)"
    ln -s "$(pwd)/wezterm.lua" "$HOME/.wezterm.lua"
else
    echo -e "${RED}wezterm is not installed.${RESET}"
fi

# betterfetch
if command -v betterfetch >/dev/null 2>&1; then
    echo -e "${GREEN}betterfetch is installed at:${RESET} $(command -v betterfetch)"
    mkdir -p "$HOME/.config/betterfetch/"
    ln -s "$(pwd)/betterfetch.toml" "$HOME/.config/betterfetch/config.toml"
else
    echo -e "${RED}betterfetch is not installed.${RESET}"
fi

# conda
if command -v conda >/dev/null 2>&1; then
    echo -e "${GREEN}conda is installed at:${RESET} $(command -v conda)"
    ln -s "$(pwd)/condarc" "$HOME/.condarc"
else
    echo -e "${RED}conda is not installed.${RESET}"
fi


# starship
if command -v starship >/dev/null 2>&1; then
    echo -e "${GREEN}starship is installed at:${RESET} $(command -v starship)"
		ln -s "$(pwd)/starship.toml" "$HOME/.config/starship.toml"
else
    echo -e "${RED}starship is not installed.${RESET}"
fi

# fastfetch (useless)
if command -v fastfetch >/dev/null 2>&1; then
    echo -e "${GREEN}fastfetch is installed at:${RESET} $(command -v fastfetch)"
		mkdir -p "$HOME/.config/fastfetch"
		ln -s "$(pwd)/fastfetch.jsonc" "$HOME/.config/fastfetch/config.jsonc"
else
    echo -e "${RED}fastfetch is not installed.${RESET}"
fi

# foot
if command -v foot >/dev/null 2>&1; then
    echo -e "${GREEN}foot is installed at:${RESET} $(command -v foot)"
		mkdir -p "$HOME/.config/foot"
		ln -s "$(pwd)/foot.ini" "$HOME/.config/foot/foot.ini"
else
    echo -e "${RED}foot is not installed.${RESET}"
fi

# Fish shell
if command -v fish >/dev/null 2>&1; then
    echo -e "${GREEN}fish is installed at:${RESET} $(command -v fish)"
		mkdir -p "$HOME/.config/fish"
		ln -s "$(pwd)/fish" "$HOME/.config"
else
    echo -e "${RED}fish is not installed.${RESET}"
fi

echo -e "${YELLOW}Done...${RESET}"
