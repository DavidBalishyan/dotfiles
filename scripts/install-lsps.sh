#!/usr/bin/env bash
# NOTE: This script is debian and Darwin(macos) only for now

source "$(dirname "$0")/board.bash"

MISSING=()
INSTALLED=()
ALREADY=()

check() {
  local name=$1 cmd=$2 install_cmd=$3
  if command -v "$cmd" &>/dev/null; then
    ALREADY+=("$name")
  else
    MISSING+=("$name")
  fi
}

install() {
  local name=$1 cmd=$2 install_cmd=$3
  paint --underline --bold --yellow "==> Installing $name ($cmd)..."
  if eval "$install_cmd"; then
    INSTALLED+=("$name")
  else
    paint --red --bold --underline "FAILED: $name - try manually: $install_cmd"
  fi
}

# Define all LSPs matching installer.lua
check lua_ls       lua-language-server          'brew install lua-language-server'
check pyright      pyright-langserver           'pip install pyright'
check ts_ls        typescript-language-server   'npm i -g typescript-language-server typescript'
check tailwindcss  tailwindcss-language-server  'npm i -g @tailwindcss/language-server'
check gopls        gopls                        'go install golang.org/x/tools/gopls@latest'
check rust_analyzer rust-analyzer               'rustup component add rust-analyzer'
check phpactor     phpactor                     'composer global require phpactor/phpactor'
check bashls       bash-language-server         'npm i -g bash-language-server'
check clangd       clangd                       'sudo apt install -y clangd'
check ruby_lsp     ruby-lsp                     'gem install ruby-lsp'

echo ""

if [ ${#ALREADY[@]} -gt 0 ]; then
  paint --green --bold --underline "Already installed (${#ALREADY[@]}):"
  printf '  %s\n' "${ALREADY[@]}"
fi

if [ ${#MISSING[@]} -eq 0 ]; then
  echo ""
  paint --underline --yellow --bold "All LSP servers are installed."
  exit 0
fi

echo ""
paint --red --bold --underline "Missing (${#MISSING[@]}):"
printf '  %s\n' "${MISSING[@]}"
echo ""

case "$(uname -s)" in
  Linux)  PKG_MGR="apt"   ;;
  Darwin) PKG_MGR="brew"  ;;
  *)      PKG_MGR="other" ;;
esac

paint --green --underline --bold "Proceeding to install missing LSP servers..."
echo ""

for name in "${MISSING[@]}"; do
  case "$name" in
    lua_ls)       install lua_ls       lua-language-server          'brew install lua-language-server' ;;
    pyright)      install pyright      pyright-langserver           'pip install pyright' ;;
    ts_ls)        install ts_ls        typescript-language-server   'npm i -g typescript-language-server typescript' ;;
    tailwindcss)  install tailwindcss  tailwindcss-language-server  'npm i -g @tailwindcss/language-server' ;;
    gopls)        install gopls        gopls                        'go install golang.org/x/tools/gopls@latest' ;;
    rust_analyzer) install rust_analyzer rust-analyzer              'rustup component add rust-analyzer' ;;
    phpactor)     install phpactor     phpactor                     'composer global require phpactor/phpactor' ;;
    bashls)       install bashls       bash-language-server         'npm i -g bash-language-server' ;;
    clangd)       install clangd       clangd                       "sudo apt install -y clangd" ;;
    ruby_lsp)     install ruby_lsp     ruby-lsp                     'gem install ruby-lsp' ;;
  esac
done

echo ""
echo "Done! Installed ${#INSTALLED[@]}/${#MISSING[@]} missing LSP servers."
if [ ${#INSTALLED[@]} -ne ${#MISSING[@]} ]; then
  echo "Some installations failed — see errors above."
fi
