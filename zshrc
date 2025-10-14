# --------------------------------------------------------------------------------------------------------------------------------
export ZSH_HOME="$HOME/.zsh"
export HISTFILE=~/.zsh_history
export HISTSIZE=5000
export SAVEHIST=5000
ZSH_PLUGINS="$ZSH_HOME/plugins"

setopt autocd
setopt hist_ignore_all_dups
setopt share_history
# --------------------------------------------------------------------------------------------------------------------------------
# enbale vi mode and init starship prompt
bindkey -v
eval "$(starship init zsh)"


source "$ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$ZSH_PLUGINS/zsh-you-should-use/you-should-use.plugin.zsh"
source "$ZSH_PLUGINS/zsh-plugin-rust/zsh-plugin-rust.plugin.zsh"

# --------------------------------------------------------------------------------------------------------------------------------
# To see a full list of active aliases run `alias`
alias ...="../.."
alias _="sudo"
alias reload="exec zsh"
alias ls="eza --git --icons"
alias g="git"
alias gc="git commit"
alias gp="git push"
alias gst="git status"
alias bfetch="betterfetch"
alias vim="nvim"
alias myip="curl https://ipecho.net/plain ; echo"
alias cat="bat -pn"
alias t="tmux"
alias top="btop"
alias shck="shellcheck"
alias cls="clear -x"
alias la="ls -la"
alias ll="ls -l"
# --------------------------------------------------------------------------------------------------------------------------------
# Path and Environment
export PATH="$HOME/.local/bin:$PATH"
export EDITOR="nvim"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/home/david/.nimble/bin:$PATH"
export PATH="/home/david/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="/home/david/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"
# --------------------------------------------------------------------------------------------------------------------------------
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"
eval "$(thefuck --alias)"
eval "$(thefuck --alias fk)"
# --------------------------------------------------------------------------------------------------------------------------------
# pnpm
export PNPM_HOME="/home/david/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export NVM_DIR="$HOME/.nvm"
[ -s "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

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
betterfetch

