-- All keymaps in one place

local map = vim.keymap.set

-- Save, quit, write-quit
map('n', '<leader>w', '<cmd>w<CR>', { desc = 'Save' })
map('n', '<leader>q', '<cmd>q<CR>', { desc = 'Quit' })
map('n', '<leader>1', '<cmd>wq<CR>', { desc = 'Write and quit' })
map('n', '<leader>Q', '<cmd>q!<CR>', { desc = 'Force quit' })

-- Clear search highlight
map('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search' })

-- Tab management
map('n', '<leader>nt', '<cmd>tabnew<CR>', { desc = 'New tab' })
map('n', '<leader>ct', '<cmd>tabclose<CR>', { desc = 'Close tab' })

-- Theme switching
map('n', '<leader>th', '<cmd>colorscheme gruvbox<CR>', { desc = 'Gruvbox theme' })
map('n', '<leader>tt', '<cmd>colorscheme tokyonight-night<CR>', { desc = 'Tokyonight theme' })
map('n', '<leader>tn', '<cmd>colorscheme carbonfox<CR>', { desc = 'Carbonfox theme' })

-- Window navigation
map('n', '<C-h>', '<C-w>h', { desc = 'Window left' })
map('n', '<C-j>', '<C-w>j', { desc = 'Window down' })
map('n', '<C-k>', '<C-w>k', { desc = 'Window up' })
map('n', '<C-l>', '<C-w>l', { desc = 'Window right' })

-- Indentation toggle
map('n', '<leader>it', function()
  if vim.o.expandtab then
    vim.o.expandtab = false
    vim.o.tabstop = 4
    vim.o.shiftwidth = 4
    vim.cmd('retab!')
    vim.print('Using tabs (4)')
  else
    vim.o.expandtab = true
    vim.o.tabstop = 4
    vim.o.shiftwidth = 4
    vim.cmd('retab')
    vim.print('Using spaces (4)')
  end
end, { desc = 'Toggle indentation (tabs/spaces)' })
