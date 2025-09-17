# -------------------------------------------------------------------------------------------------------------------------------- This config uses Oh My ZSH and PowerLevel10k
# Made on ZSH 5.9 and Debian 13
# Oh My ZSH: https://github.com/ohmyzsh/ohmyzsh
# Powerlevel10k: https://github.com/romkatv/powerlevel10k
# Creator: https://github.com/DavidBalishyan
# Github repo: https://github.com/DavidBalishyan/dotfiles
# --------------------------------------------------------------------------------------------------------------------------------


# ---------------------------------------------------------------------------------------------------------------------------
#	  																	 Enable Powerlevel10k instant prompt. 
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# Code, that requires input, should go on top of this.
# Everything else may go below
# --------------------------------------------------------------------------------------------------------------------------------


# --------------------------------------------------------------------------------------------------------------------------------
# 																									General configs
# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# --------------------------------------------------------------------------------------------------------------------------------
plugins=(
	git
	tmux
	zsh-plugin-rust
	you-should-use
	zsh-autosuggestions
)

# Source the oh-my-zsh activation script
source $ZSH/oh-my-zsh.sh

# To see a full list of active aliases run `alias`
alias reload="exec zsh"
alias ls="eza --icons"
alias bfetch="betterfetch"
alias vim="nvim"
alias myip="curl https://ipecho.net/plain ; echo"
alias cat="bat -pn"
alias t="tmux"
alias top="btop"
# --------------------------------------------------------------------------------------------------------------------------------

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# --------------------------------------------------------------------------------------------------------------------------------
# Added by betterfetch installer
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/bin:$PATH"

eval "$(zoxide init zsh)"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

  export NVM_DIR="$HOME/.nvm"
  [ -s "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm"
