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
