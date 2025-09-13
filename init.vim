" Enable numbered lines
set nu
set rnu
" Tab config
set tabstop=2
set shiftwidth=2
" Status bar
set laststatus=2
highlight VertSplit guibg=#181818 guifg=#996228
highlight SLBackground guibg=#181818 guifg=#996229
highlight SLFileType guibg=indianred guifg=#663333
highlight SLBufNumber guibg=SeaGreen guifg=#003333
highlight SLLineNumber guibg=#80a0ff guifg=#003366
set statusline=\%#SLBackground#
" set statusline+=\%/
set statusline+=\%= " separator
set statusline+=\ %#SLFileType#
set statusline+=\ FT:\ %Y
set statusline+=\ %#SLBufNumber#
set statusline+=\ BN:\ %n
set statusline+=\ %#SLLineNumber#
set statusline+=\ LN:\ %l
" Set the right encoding
set encoding=utf-8
" Enable syntax highlighting
syntax on
" Indentation
set autoindent
set smartindent
" Colorsceme
set termguicolors
colo habamax
" Keymaps
let mapleader=" "
nnoremap <Leader>cc :set colorcolumn=80<cr>
nnoremap <Leader>ncc :set colorcolumn-=80<cr>
nnoremap <Leader>w :w<cr>
nnoremap <Leader>q :q<cr>
nnoremap <Leader>1 :x<cr>
nnoremap <Leader>e :Explore<cr>
nnoremap <Leader>o :Vexplore<cr>
nnoremap <Leader>Q :q!<cr>
" Set mouse on
set mouse=a
