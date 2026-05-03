# My Neovim Configuration

A fast, minimal Neovim setup built with **vim.pack** (Neovim 0.10+ built-in package manager). No external plugin manager required.

---

## Features

* **No Plugin Manager**: Uses native `vim.pack` for fast startup and zero dependency on third-party plugin managers.
* **Enhanced Notifications**: Powered by [noice.nvim](https://github.com/folke/noice.nvim) and [nvim-notify](https://github.com/rcarriga/nvim-notify).
* **LSP Support**: Preconfigured with [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig), [lazydev.nvim](https://github.com/folke/lazydev.nvim), and [fidget.nvim](https://github.com/j-hui/fidget.nvim).
* **Autocompletion & Snippets**: Powered by [blink.cmp](https://github.com/Saghen/blink.cmp) and [LuaSnip](https://github.com/L3MON4D3/LuaSnip).
* **File Navigation**: Fuzzy finding with [Telescope.nvim](https://github.com/nvim-telescope/telescope.nvim), file explorer via [oil.nvim](https://github.com/stevearc/oil.nvim) and [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim).
* **UI Enhancements**: Clean statusline with [lualine](https://github.com/nvim-lualine/lualine.nvim), start screen via [alpha-nvim](https://github.com/goolord/alpha-nvim), key hints with [which-key.nvim](https://github.com/folke/which-key.nvim).
* **Git Integration**: Inline blame and diff decorations with [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim).
* **Formatting**: Auto-formatting via [conform.nvim](https://github.com/stevearc/conform.nvim).
* **Utility Plugins**: Includes [Comment.nvim](https://github.com/numToStr/Comment.nvim), [nvim-autopairs](https://github.com/windwp/nvim-autopairs), [mini.nvim](https://github.com/echasnovski/mini.nvim), [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim), and [todo-comments.nvim](https://github.com/folke/todo-comments.nvim).

---

## Prerequisites

* **Neovim 0.10+** (required for `vim.pack`)

---

## Installation

1. **Backup Existing Configuration** (Optional):

```bash
mv ~/.config/nvim ~/.config/nvim.bak
```

2. **Clone the Repository**:

```bash
git clone https://github.com/DavidBalishyan/nvim.git ~/.config/nvim
```

3. **Launch Neovim**:

```bash
nvim
```

Plugins are automatically managed via `vim.pack` — no manual installation step needed.

---

## Configuration

| Path | Purpose |
| --- | --- |
| `init.lua` | Entry point — all plugins registered via `vim.pack.add()` |
| `lua/core/` | Core settings, keymaps, autocmds |
| `lua/lsp/` | LSP configuration |
| `lua/plugins/` | Individual plugin configurations |

---

## Plugins

| Plugin | Purpose |
| --- | --- |
| [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) | Colorscheme (default) |
| [catppuccin/nvim](https://github.com/catppuccin/nvim) | Colorscheme |
| [gruvbox.nvim](https://github.com/ellisonleao/gruvbox.nvim) | Colorscheme |
| [nightfox.nvim](https://github.com/EdenEast/nightfox.nvim) | Colorscheme |
| [guess-indent.nvim](https://github.com/NMAC427/guess-indent.nvim) | Auto-detect indent settings |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP configurations |
| [lazydev.nvim](https://github.com/folke/lazydev.nvim) | Lua LSP for Neovim plugin development |
| [fidget.nvim](https://github.com/j-hui/fidget.nvim) | LSP progress indicator |
| [blink.cmp](https://github.com/Saghen/blink.cmp) | Autocompletion engine |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippet engine |
| [Telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder |
| [oil.nvim](https://github.com/stevearc/oil.nvim) | File explorer (buffer-based) |
| [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) | File explorer (sidebar) |
| [Comment.nvim](https://github.com/numToStr/Comment.nvim) | Easy commenting |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Autopairing |
| [mini.nvim](https://github.com/echasnovski/mini.nvim) | Minimal Lua plugins |
| [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) | Markdown rendering |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Statusline |
| [noice.nvim](https://github.com/folke/noice.nvim) | UI replacements |
| [nvim-notify](https://github.com/rcarriga/nvim-notify) | Notification manager |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Key binding popup |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | Highlight TODO/FIXME/etc. |
| [alpha-nvim](https://github.com/goolord/alpha-nvim) | Start screen |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git decorations |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Formatter |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | File icons |

---

## License

This configuration is open-source and available under the [MIT License](LICENSE).
