# ------------------------------------------------------------
export ZSH_HOME="$HOME/.zsh"
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=5000
export SAVEHIST=5000
export ZSH_PLUGINS="$ZSH_HOME/plugins"
export ZSH_THEMES="$ZSH_HOME/themes"
setopt autocd
setopt hist_ignore_all_dups
setopt share_history
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
# Colored man pages
export LESS_TERMCAP_mb=$'\e[1;31m'      # begin blinking
export LESS_TERMCAP_md=$'\e[1;31m'      # begin bold (red)
export LESS_TERMCAP_me=$'\e[0m'         # end mode
export LESS_TERMCAP_se=$'\e[0m'         # end standout-mode
export LESS_TERMCAP_so=$'\e[1;44;33m'   # begin standout-mode (info box)
export LESS_TERMCAP_ue=$'\e[0m'         # end underline
export LESS_TERMCAP_us=$'\e[1;32m'      # begin underline (green)
export GROFF_NO_SGR=1                   # necessary for some terminals

# check if a command is installed on the system
is_installed () {
    command -v "$1" &> /dev/null
}

# Load pure prompt
load_pure() {
	fpath+=($ZSH_THEMES/pure)
	autoload -U promptinit; promptinit
	prompt pure
}

# Load powerlevel10k
load_p10k() {
	source "$ZSH_THEMES/powerlevel10k/powerlevel10k.zsh-theme"
	[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
}


function nvims() {
  items=(
		"default"
		"justaguylinux-nvim"
		"LazyVim"
		"AstroNvim"
	)
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}
# ------------------------------------------------------------
# enbale vi mode
bindkey -v

source "$ZSH_THEMES/simple.zsh-theme"

# Starship
if is_installed starship; then
	eval "$(starship init zsh)"
fi

# ------------------------------------------------------------

fpath=($ZSH_PLUGINS/zsh-completions/src $fpath)
autoload -U compinit && compinit

source "$ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$ZSH_PLUGINS/zsh-you-should-use/you-should-use.plugin.zsh"
source "$ZSH_PLUGINS/zsh-plugin-rust/zsh-plugin-rust.plugin.zsh"
source "$ZSH_PLUGINS/aliases/aliases.plugin.zsh"
# source "$ZSH_PLUGINS/zsh-completions/zsh-completions.plugin.zsh"

# ------------------------------------------------------------
# To see a full list of active aliases run `alias`
alias ...="../.."
alias _="sudo"
alias suod="sudo"
alias myip="curl https://ipecho.net/plain ; echo"
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
alias mk="makeover"

if is_installed git; then
	alias g="git"
	alias gc="git commit"
	alias gp="git push"
	alias gst="git status"
	alias ga="git add"
fi

if is_installed bat; then
	alias cat="bat -pn"
fi

if is_installed tmux; then 
	alias t="tmux"
tm() {
  local session="${1:-Main}"
	  if tmux has-session -t "$session" 2>/dev/null; then
	    tmux attach-session -t "$session"
	  else
	    echo "Session '$session' not found. Creating new one..."
	    tmux new-session -s "$session"
	  fi
	}
fi

if is_installed btop; then
	alias top="btop"
fi

if is_installed shellcheck; then
	alias shck="shellcheck"
fi

if is_installed nvim; then
	alias vim="nvim"
	alias v="nvim"
fi

if is_installed just; then
	alias j="just"
fi
# ------------------------------------------------------------
# Path and Environment
export EDITOR="nvim"
export TERMINAL="alacritty"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.nimble/bin:$PATH"
export PATH="$HOME.config/herd-lite/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.opencode/bin:$PATH"
export PATH="$HOME/.config/herd-lite/bin:$PATH"
export PATH="$HOME/.local/share/gem/ruby/3.3.0/bin:$PATH"
export PATH="$HOME/.gem/bin:$PATH"
export GEM_HOME="$HOME/.gem"
export PHP_INI_SCAN_DIR="$HOME/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"
# ------------------------------------------------------------

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"
eval "$(thefuck --alias)"
eval "$(thefuck --alias fk)"

# ------------------------------------------------------------
# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

. "$HOME/.nvm/nvm.sh"
. "$HOME/.deno/env"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/.miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/.miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/.miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/.miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# https://github.com/betterfetch/betterfetch
if is_installed betterfetch; then
	alias bfetch="betterfetch"
fi

# https://github.com/DavidBalishyan/namaskar
if is_installed namaskar; then
	namaskar
fi

if is_installed timedate; then
	timedate
fi

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
