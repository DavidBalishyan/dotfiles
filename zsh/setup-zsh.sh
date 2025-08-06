#/bin/bash

# ------------------------------------------------------------------------------------------------
#                           A bash script to setup ZSH with ohMyZsh and p10k
# Repo: https://github.com/DavidBalishyan/dotfiles
# Creator: https://github.com/DavidBalishyan
# ------------------------------------------------------------------------------------------------

# ------------------------------------------------------------------------------------------------
#                                         Getting the resources
curl https://raw.githubusercontent.com/DavidBalishyan/dotfiles/refs/heads/main/zsh/.zshrc >~/.zshrc
git clone https://github.com/DavidBalishyan/ohmyzsh.git >~/.oh-my-zsh/ # ohMyZsh + p10k
# ------------------------------------------------------------------------------------------------

# Restart Zsh
exec zsh
