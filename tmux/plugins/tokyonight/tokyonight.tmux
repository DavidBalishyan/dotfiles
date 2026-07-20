#!/usr/bin/env bash
#  Tokyo Night - a tmux theme
#  https://github.com/folke/tokyonight.nvim (palette source)
#
#  Usage (from ~/.tmux.conf):
#     run-shell "~/.config/tmux/plugins/tokyonight/tokyonight.tmux"
#
#  Options (set BEFORE the run-shell line):
#     set -g @tokyonight_flavor  'night'   # night | storm | moon | day
#     set -g @tokyonight_left    ' #S '    # text for the session block
get() {
	local value
	value="$(tmux show-option -gqv "$1")"
	[ -n "$value" ] && echo "$value" || echo "$2"
}

flavor="$(get "@tokyonight_flavor" "night")"

# Palette
# Shared accents (identical across the dark flavors)
fg="#c0caf5"
fg_dark="#a9b1d6"
comment="#565f89"
blue="#7aa2f7"
cyan="#7dcfff"
green="#9ece6a"
magenta="#bb9af7"
orange="#ff9e64"
red="#f7768e"
yellow="#e0af68"

case "$flavor" in
storm)
	bg="#24283b"      # background
	bg_dark="#1f2335" # darker inactive bar
	bg_hl="#292e42"   # subtle highlight / inactive window bg
	;;
moon)
	bg="#222436"
	bg_dark="#1e2030"
	bg_hl="#2f334d"
	fg="#c8d3f5"
	fg_dark="#828bb8"
	comment="#636da6"
	blue="#82aaff"
	cyan="#86e1fc"
	green="#c3e88d"
	magenta="#c099ff"
	orange="#ff966c"
	red="#ff757f"
	yellow="#ffc777"
	;;
day)
	bg="#e1e2e7"
	bg_dark="#d0d5e3"
	bg_hl="#c4c8da"
	fg="#3760bf"
	fg_dark="#6172b0"
	comment="#848cb5"
	blue="#2e7de9"
	cyan="#007197"
	green="#587539"
	magenta="#9854f1"
	orange="#b15c00"
	red="#f52a65"
	yellow="#8c6c3e"
	;;
*) # night (default)
	bg="#1a1b26"
	bg_dark="#16161e"
	bg_hl="#292e42"
	;;
esac

left_text="$(get "@tokyonight_left" " #S ")"

# Powerline separators (need a Nerd Font / powerline-patched font)
sep_r=""   # right-pointing (left side)
sep_l=""   # left-pointing  (right side)

# General
tmux set -g status on
tmux set -g status-interval 5
tmux set -g status-justify left
tmux set -g status-position bottom
tmux set -g status-style "bg=$bg_dark,fg=$fg_dark"

# Message / command prompt
tmux set -g message-style "bg=$bg_hl,fg=$cyan"
tmux set -g message-command-style "bg=$bg_hl,fg=$cyan"

# Pane borders
tmux set -g pane-border-style "fg=$bg_hl"
tmux set -g pane-active-border-style "fg=$blue"

# Copy / selection
tmux set -g mode-style "bg=$blue,fg=$bg"

# Clock
tmux set -g clock-mode-colour "$blue"

# Left: session block
tmux set -g status-left-length 40
tmux set -g status-left \
	"#[bg=$blue,fg=$bg,bold]$left_text#[bg=$bg_dark,fg=$blue]$sep_r "

# Right: prefix indicator - date - time - host
tmux set -g status-right-length 80
tmux set -g status-right \
	"#{?client_prefix,#[fg=$orange]$sep_l#[bg=$orange]#[fg=$bg]#[bold] PREFIX #[default] ,}\
#[fg=$bg_hl]$sep_l#[bg=$bg_hl]#[fg=$cyan] %a %d %b \
#[fg=$comment]$sep_l#[bg=$comment]#[fg=$bg]#[bold] %H:%M \
#[bg=$blue]#[fg=$bg]#[bold]$sep_l #H "

# Windows
tmux set -g window-status-separator ""

# Inactive window
tmux set -g window-status-format \
	"#[bg=$bg_dark,fg=$comment] #I #[fg=$fg_dark]#W#{?window_flags,#[fg=$orange]#F,} "

# Active window
tmux set -g window-status-current-format \
	"#[bg=$bg_dark,fg=$magenta]$sep_r#[bg=$magenta,fg=$bg,bold] #I #[bg=$bg_hl,fg=$fg,bold] #W#{?window_flags,#[fg=$orange]#F,} #[bg=$bg_dark,fg=$bg_hl]$sep_r"

# Window with a bell / activity
tmux set -g window-status-bell-style "fg=$red,bold"
tmux set -g window-status-activity-style "fg=$yellow"
