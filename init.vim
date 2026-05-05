" Make vim not behave like vi
set nocp
set number
set relativenumber
set encoding=utf-8
set termguicolors
colo habamax
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
set statusline=\%#SLBackground#
set statusline+=\%= " separator
set statusline+=\ %#SLFileType#
set statusline+=\ FT:\ %Y
set statusline+=\ %#SLBufNumber#
set statusline+=\ BN:\ %n
set statusline+=\ %#SLLineNumber#
set statusline+=\ LN:\ %l
