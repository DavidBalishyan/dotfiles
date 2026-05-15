-- Autocommands grouped logically

local api = vim.api

-- Yank highlight
local yank_group = api.nvim_create_augroup('yank_highlight', { clear = true })
api.nvim_create_autocmd('TextYankPost', {
  group = yank_group,
  callback = function()
    vim.hl.on_yank()
  end,
})

local makefile_group = api.nvim_create_augroup('makefile_indent', { clear = true })
api.nvim_create_autocmd('FileType', {
  group = makefile_group,
  pattern = 'make',
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})
