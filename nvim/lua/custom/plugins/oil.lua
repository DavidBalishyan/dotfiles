-- lua/custom/oli.lua
return {
  'stevearc/oil.nvim',
  dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  lazy = false,
  config = function()
    require('oil').setup {
      view_options = {
        show_hidden = true,
        show_parent = false,
      },
      default_file_explorer = true,
      columns = { 'icon', 'size', 'mtime' },
    }

    -- Keymap to open parent directory
    vim.keymap.set('n', '<leader>e', '<Cmd>Oil<CR>', { desc = 'Open parent directory' })
  end,
}
