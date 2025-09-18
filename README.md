# Dotfiles

My personal dotfiles. 

This repo contains configuration files and setup scripts for Vim, Zsh, tmux, and other tools I use daily.  
It also includes a `Brewfile` for installing essential packages with [Homebrew on Linux](https://brew.sh)

---

## Contents

| File / Folder        | Purpose |
|----------------------|---------|
| `init.vim`           | Vim configuration. |
| `nvim/`              | Neovim configuration. |
| `emacs.el`           | Main Emacs(the worst text editor of all time) configuration. |
| `emacs.custom.el`    | Custom Emacs(the worst text editor of all time) settings (auto-generated or local tweaks). |
| `zshrc`             | Zsh shell configuration. |
| `tmux.conf`         | tmux multiplexer configuration. |
| `Brewfile`           | List of packages to install with Homebrew. |
| `setup.sh`           | Script to symlink configs and set up the environment. |

---

## Prerequisites

- **[Linux](https://github.com/torvalds/linux)** (tested on Debian and Arch, should work on most distros)  
- **[git](https://github.com/git/git)**  
- **[Hombrew for Linux](https://brew.sh)** 
- Optional tools you’ll probably want:  
  - Zsh  
  - tmux  
  - Vim  
  - Neovim
  - Emacs  

---

## Installation

Clone the repo:

```bash
git clone https://github.com/DavidBalishyan/dotfiles.git
cd dotfiles
```

Install packages from the `Brewfile`:

```bash
brew bundle 
```

Back up old configs if needed:

```bash
mv ~/.zshrc ~/.zshrc.bak
mv ~/.tmux.conf ~/.tmux.conf.bak
mv ~/.vimrc ~/.vimrc.bak
mv ~/.config/nvim ~/.config/nvim.bak
```

Run the setup script (creates symlinks):

```bash
./setup.sh
```

---

## Packages from `Brewfile`

Here’s what gets installed when you run `brew bundle`:

| Package    | Purpose |
|------------|---------|
| `neovim` | Modern Vim-based text editor. |
| `vim` | Classic text editor. |
| `curl` | Transfer data from or to a server. |
| `wget` | Command-line downloader. |
| `httpie` | User-friendly command-line HTTP client. |
| `openssh` | OpenSSH connectivity tools (ssh, scp, etc.). |
| `git` | Version control system. |
| `gcc` | GNU Compiler Collection (C, C++, etc.). |
| `rustup-init` | Rust toolchain installer. |
| `node` | JavaScript runtime (Node.js). |
| `nvm` | Node.js version manager. |
| `python@3.12` | Python 3.12 and pip3. |
| `go(golang)` | The go programming language |
| `ripgrep` | Fast search tool, like grep but better. |
| `fd` | User-friendly alternative to find. |
| `bat` | A better cat with syntax highlighting. |
| `eza` | Modern replacement for ls with more features. |
| `fzf` | Fuzzy finder for command-line search. |
| `btop` | Modern system monitor, alternative to top/htop. |
| `lsof` | List open files and the processes using them. |
| `xz` | Compression utilities (xz, lzma). |
| `jq` | Command-line JSON processor. |
| `yq` | Command-line YAML processor. |
| `gnupg` | GNU Privacy Guard, encryption and signing. |
| `openssl@3` | OpenSSL cryptography library, version 3. |
| `make` | Build automation tool. |
| `cmake` | Cross-platform build system generator. |

---

## Usage & Customization

- **Emacs** -> put overrides in `emacs.el`  
- **Vim** -> edit `init.vim` for settings  
- **Zsh** -> add aliases/functions in `zshrc`  
- **tmux** -> tweak keybindings in `tmux.conf`  
- **Neovim** -> Change config in `nvim/`
---

## Notes

- Configs are tailored for Linux.  
- `Brewfile` makes it easy to bootstrap a system with the same packages.  
- Some configs depend on CLI tools (`fzf`, `ripgrep`, `bat`, etc.) - all included in the `Brewfile`.  

---

## License

MIT License - use and adapt freely.

