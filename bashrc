# ble.sh
source "$HOME/.local/share/blesh/ble.sh"

[[ -f /etc/bashrc ]] && . /etc/bashrc

shopt -s checkwinsize   # keep LINES/COLUMNS current after each command
shopt -s histappend     # append to history, don't overwrite

HISTSIZE=5000
HISTFILESIZE=10000
HISTCONTROL=ignoreboth  # skip duplicates and lines starting with space

RESET="\[\e[0m\]"
CYAN="\[\e[36m\]"
BLUE="\[\e[34m\]"

prompt_dir() {
  if [[ "$PWD" == "$HOME" ]]; then
    PS1="${CYAN}\$ ${RESET}"
  else
    PS1="${BLUE}\w ${RESET}${CYAN}\$ ${RESET}"
  fi
}
PROMPT_COMMAND=prompt_dir

alias ls='ls --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'
alias _="sudo"
alias suod="sudo"
alias reload="exec zsh"
alias cls="clear -x"
alias la="ls -lhia"
alias ll="ls -lha"
alias l="ls -a"
alias q="exit"
alias ls="eza --git --icons"
alias tree="eza --tree"
alias apt="sudo apt"
alias df="df -h"
alias off="/sbin/poweroff"
alias reboot="/sbin/reboot"
alias myip_extern="curl https://ysap.sh/ip"

if  command -v nvim &>/dev/null; then
	alias vim="nvim"
fi

[[ -d "$HOME/.local/bin" ]] && PATH="$HOME/.local/bin:$PATH"
[[ -d "$HOME/bin" ]]        && PATH="$HOME/bin:$PATH"

