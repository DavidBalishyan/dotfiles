-- alpha-nvim (dashboard) config

local alpha = require 'alpha'
local dashboard = require 'alpha.themes.dashboard'

-- ASCII art for header
local art = {
  '                                              __   ',
  '   ___  ___  __ _ _ __ ___  ___  ___  _ __   / /_  ',
  '  / __|/ _ \\/ _` | \'__/ _ \\/ __|/ _ \\| \'_ \\ / / /  ',
  '  \\__ \\  __/ (_| | | |  __/\\__ \\ (_) | | | / /_/   ',
  '  |___/\\___|\\__, |_|  \\___||___/\\___/|_| |_/\\_/    ',
  '            |___/                                  ',
}
dashboard.section.header.val = art

-- Buttons
dashboard.section.buttons.val = {
  dashboard.button('e', '  New file', ':ene <BAR> startinsert <CR>'),
  dashboard.button('f', '󰈞  Find file', ':Telescope find_files<CR>'),
  dashboard.button('r', '  Recent', ':Telescope oldfiles<CR>'),
  dashboard.button('q', '󰅚  Quit', ':qa<CR>'),
}

alpha.setup(dashboard.config)
