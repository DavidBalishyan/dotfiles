-- oil.nvim config

require('oil').setup {
  view_options = {
    show_hidden = true,
    show_parent = false,
  },
  default_file_explorer = true,
  columns = { 'icon', 'size', 'mtime' },
}

vim.keymap.set('n', '<leader>e', '<Cmd>Oil<CR>', { desc = 'Open parent directory' })
