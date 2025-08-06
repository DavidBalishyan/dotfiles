# --------------------------------------------------------------------------------------------------------------------------------
# This config uses Oh My ZSH and PowerLevel10k
# ZSH version 5.9
# Oh My ZSH: https://github.com/ohmyzsh/ohmyzsh
# Powerlevel10k: https://github.com/romkatv/powerlevel10k
# Creator: https://github.com/DavidBalishyan
# --------------------------------------------------------------------------------------------------------------------------------

# --------------------------------------------------------------------------------------------------------------------------------
#                                           Enable p10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# Code, that requires input, should go on top of this.
# Everything else may go below
# --------------------------------------------------------------------------------------------------------------------------------

# --------------------------------------------------------------------------------------------------------------------------------
#                                                 Configs 
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
# Path to your Oh My Zsh installation. ~/.oh-my-zsh by default
export ZSH="$HOME/.oh-my-zsh"

# ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_THEME="robbyrussell"


# use another custom folder than $ZSH/custom
# ZSH_CUSTOM=/path/to/new-custom-folder
# --------------------------------------------------------------------------------------------------------------------------------

# --------------------------------------------------------------------------------------------------------------------------------
#                                               Plugins
plugins=(
  git
  bun 
  zsh-autosuggestions
  you-should-use
  tmux
)
# --------------------------------------------------------------------------------------------------------------------------------

# Source The oh-my-zsh activation script
source $ZSH/oh-my-zsh.sh

# --------------------------------------------------------------------------------------------------------------------------------
#                                             Personal configs
# Aliases
# For a full list of active aliases, run `alias`.
alias reload_zsh="exec zsh"
# alias nvim="NVIM_APPNAME=nvim-test nvim"
alias myip="curl https://ipecho.net/plain ; echo"
alias ls="eza"
export GREET_MSG=$(figlet Welcome!)
# --------------------------------------------------------------------------------------------------------------------------------

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# --------------------------------------------------------------------------------------------------------------------------------
#                                           CLI tool configs
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # Loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # Loads nvm bash_completion
. "/home/david/.deno/env"
# Zoxide
eval "$(zoxide init zsh)"


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/david/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/david/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/david/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/david/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

