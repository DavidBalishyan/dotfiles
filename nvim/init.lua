-- Neovim config - vim.pack based, no plugin manager

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

local gh = function(x)
  return 'https://github.com/' .. x
end

-- Add all plugins via vim.pack
vim.pack.add({
  -- Colorschemes
  { src = gh('folke/tokyonight.nvim'), priority = 1000 },
  { src = gh('catppuccin/nvim'), name = 'catppuccin', priority = 1000 },
  { src = gh('ellisonleao/gruvbox.nvim'), priority = 1000 },
  { src = gh('EdenEast/nightfox.nvim'), priority = 1000 },

  -- Core
  gh('NMAC427/guess-indent.nvim'),

  -- LSP
  gh('neovim/nvim-lspconfig'),
  gh('folke/lazydev.nvim'),
  gh('j-hui/fidget.nvim'),

  -- Completion
  gh('saghen/blink.lib'),
  gh('saghen/blink.cmp'),
  gh('L3MON4D3/LuaSnip'),

  -- Editing
  gh('numToStr/Comment.nvim'),
  gh('windwp/nvim-autopairs'),
  gh('echasnovski/mini.nvim'),
  gh('MeanderingProgrammer/render-markdown.nvim'),

  -- UI
  gh('nvim-lualine/lualine.nvim'),
  gh('folke/noice.nvim'),
  gh('rcarriga/nvim-notify'),
  gh('MunifTanjim/nui.nvim'),
  gh('folke/which-key.nvim'),
  gh('folke/todo-comments.nvim'),
  gh('goolord/alpha-nvim'),
  gh('MaximilianLloyd/ascii.nvim'),

  -- Navigation
  gh('nvim-telescope/telescope.nvim'),
  gh('nvim-lua/plenary.nvim'),
  gh('nvim-telescope/telescope-ui-select.nvim'),
  gh('stevearc/oil.nvim'),
  gh('nvim-neo-tree/neo-tree.nvim'),

  -- Git
  gh('lewis6991/gitsigns.nvim'),

  -- Dependencies
  gh('nvim-tree/nvim-web-devicons'),
  gh('echasnovski/mini.icons'),

  -- Formatting
  gh('stevearc/conform.nvim'),
})

require 'core.options'
require 'core.keymaps'
require 'core.autocmds'
require 'lsp'
require 'plugins.lualine'
require 'plugins.telescope'
require 'plugins.gitsigns'
require 'plugins.comment'
require 'plugins.oil'
require 'plugins.neo-tree'
require 'plugins.alpha'
require 'plugins.noice'
require 'plugins.which-key'
require 'plugins.render-md'
require 'plugins.autopairs'
require 'plugins.todo'
require 'plugins.mini'
require 'plugins.conform'
require 'plugins.blink-cmp'

-- Apply colorscheme
require('tokyonight').setup {
  styles = { comments = { italic = true } },
}

vim.cmd.colorscheme 'tokyonight-night'
