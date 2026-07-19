" Make vim not behave like vi
set nocp
set number
set relativenumber
set encoding=utf-8
set termguicolors
" Theme start
set background=dark

hi clear
if exists("syntax_on")
  syntax reset
endif

highlight Normal       guifg=#c0caf5 guibg=#1a1b26
highlight Comment      guifg=#565f89 gui=italic
highlight Constant     guifg=#ff9e64
highlight String       guifg=#9ece6a
highlight Identifier   guifg=#7aa2f7
highlight Function     guifg=#7dcfff
highlight Statement    guifg=#bb9af7
highlight Type         guifg=#2ac3de
highlight PreProc      guifg=#f7768e
highlight Special      guifg=#e0af68
highlight LineNr       guifg=#3b4261
highlight CursorLineNr guifg=#737aa2
highlight StatusLine   guifg=#c0caf5 guibg=#24283b
highlight VertSplit    guifg=#3b4261 guibg=#1a1b26
highlight Visual       guibg=#33467c
highlight Search       guifg=#1a1b26 guibg=#e0af68
highlight Pmenu        guifg=#c0caf5 guibg=#24283b
highlight PmenuSel     guifg=#1a1b26 guibg=#7aa2f7
" Theme end
set mouse=a
set autoindent
set smartindent
syntax on
filetype plugin indent on
" Pure vim fuzzy file finding
set path+=**
set wildmenu
let mapleader=" "
nnoremap <Leader>cc :set colorcolumn=80<cr>
nnoremap <Leader>ncc :set colorcolumn-=80<cr>
nnoremap <Leader>w :w<cr>
nnoremap <Leader>q :q<cr>
nnoremap <Leader>1 :x<cr>
nnoremap <Leader>e :Explore<cr>
nnoremap <Leader>f :F<cr>
nnoremap <Leader>o :Vexplore<cr>
nnoremap <Leader>Q :q!<cr>
nnoremap <Leader>s :so<cr>
set tabstop=2
set shiftwidth=2
set laststatus=2
highlight VertSplit guibg=#181818 guifg=#996228
highlight SLBackground guibg=#181818 guifg=#996229
highlight SLFileType guibg=indianred guifg=#663333
highlight SLBufNumber guibg=SeaGreen guifg=#003333
highlight SLLineNumber guibg=#80a0ff guifg=#003366
" Statusline start
highlight VertSplit guifg=#3b4261 guibg=#1a1b26

highlight SLBackground guifg=#c0caf5 guibg=#24283b
highlight SLFileType guifg=#7dcfff guibg=#1f2335
highlight SLBufNumber guifg=#bb9af7 guibg=#1f2335
highlight SLLineNumber guifg=#9ece6a guibg=#1f2335

set statusline=\%#SLBackground#
set statusline+=\ %f
set statusline+=\%=

set statusline+=\ %#SLFileType#
set statusline+=\ FT:\ %Y

set statusline+=\ %#SLBufNumber#
set statusline+=\ BN:\ %n

set statusline+=\ %#SLLineNumber#
set statusline+=\ LN:\ %l:%c
" Statusline end
