#!/usr/bin/env bash

# ------------------------------------------------------------------------------------------------
#                           A bash script to setup ZSH with ohMyZsh and p10k
# Repo: https://github.com/DavidBalishyan/dotfiles
# Creator: https://github.com/DavidBalishyan
# ------------------------------------------------------------------------------------------------

# ------------------------------------------------------------------------------------------------
#                                         Getting the resources
curl https://raw.githubusercontent.com/DavidBalishyan/dotfiles/refs/heads/main/.zshrc > ~/.zshrc
git clone https://github.com/DavidBalishyan/ohmyzsh.git ~/.oh-my-zsh/ # ohMyZsh + p10k
# ------------------------------------------------------------------------------------------------

