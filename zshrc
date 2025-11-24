# ------------------------------------------------------------
export ZSH_HOME="$HOME/.zsh"
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=5000
export SAVEHIST=5000
export ZSH_PLUGINS="$ZSH_HOME/plugins"
export ZSH_THEMES="$ZSH_HOME/themes"
export TERMINAL="alacritty"
setopt autocd
setopt hist_ignore_all_dups
setopt share_history

# check if a command is installed on the system
is_installed () {
    command -v "$1" &> /dev/null
}

# ------------------------------------------------------------
# enbale vi mode
bindkey -v

source "$ZSH_THEMES/simple.zsh-theme"

# Starship
if is_installed starship; then
	eval "$(starship init zsh)"
fi

# ------------------pure prompt-------------------------------
load_pure() {
	fpath+=($ZSH_THEMES/pure)
	autoload -U promptinit; promptinit
	prompt pure
}

# ------------------powerlevel10k-----------------------------
load_p10k() {
	source "$ZSH_THEMES/powerlevel10k/powerlevel10k.zsh-theme"
	[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
}

# ------------------------------------------------------------

source "$ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$ZSH_PLUGINS/zsh-you-should-use/you-should-use.plugin.zsh"
source "$ZSH_PLUGINS/zsh-plugin-rust/zsh-plugin-rust.plugin.zsh"
source "$ZSH_PLUGINS/aliases/aliases.plugin.zsh"

# ------------------------------------------------------------
# To see a full list of active aliases run `alias`
alias ...="../.."
alias _="sudo"
alias suod="sudo"
alias myip="curl https://ipecho.net/plain ; echo"
alias reload="exec zsh"
alias cls="clear -x"
alias la="ls -lha"
alias ll="ls -lh"
alias l="ls -a"
alias q="exit"
alias ls="eza --git --icons"
alias apt="sudo apt"
alias df="df -h"
alias off="/sbin/poweroff"

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
	# alias att="tmux attach -t $1"
tm() {
  local session="${1:-0}"
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
fi

# ------------------------------------------------------------
# Path and Environment
export PATH="$HOME/.local/bin:$PATH"
export EDITOR="nvim"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/home/david/.nimble/bin:$PATH"
export PATH="/home/david/.config/herd-lite/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PHP_INI_SCAN_DIR="/home/david/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"

# ------------------------------------------------------------
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"
# eval "$(thefuck --alias)"
# eval "$(thefuck --alias fk)"

# ------------------------------------------------------------
# pnpm
export PNPM_HOME="/home/david/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

. "$HOME/.nvm/nvm.sh"

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


# Just to show a nice fetch app when logged into the terminal
if is_installed betterfetch; then
	betterfetch
	alias bfetch="betterfetch"
fi

