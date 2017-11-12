let mapleader = ","

packadd minpac
call minpac#init()

command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()

call minpac#add('tpope/vim-sensible')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('terryma/vim-expand-region')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-repeat')

call minpac#add('tpope/vim-dispatch')
call minpac#add('radenling/vim-dispatch-neovim')

call minpac#add('tpope/vim-vinegar')
call minpac#add('tpope/vim-projectionist')
call minpac#add('junegunn/fzf.vim')

call minpac#add('tpope/vim-fugitive')

call minpac#add('mihaifm/bufstop')
nnoremap <leader>b :BufstopFast<CR>
let g:BufstopSorting = "none"

call minpac#add('gcmt/taboo.vim')
let g:taboo_renamed_tab_format = " %N%m:%l "
let g:taboo_modified_tab_flag = "*"

call minpac#add('itchyny/lightline.vim')

call minpac#add('frankier/neovim-colors-solarized-truecolor-only')
set background=dark
set termguicolors
colorscheme solarized

syntax enable

set tabstop=4
set softtabstop=4
set expandtab
set number
set showcmd
set cursorline
set showmatch
set incsearch
set hlsearch

nnoremap <leader><space> :nohlsearch<CR>
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>

tnoremap <Esc> <C-\><C-n>
tnoremap <C-v><Esc> <Esc>
:au BufEnter * if &buftype == 'terminal' | :startinsert | endif
highlight! TermCursor ctermbg=0 ctermfg=118
highlight! TermCursorNC ctermbg=196 ctermfg=0

nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l
inoremap <M-h> <C-w>h
inoremap <M-j> <C-w>j
inoremap <M-k> <C-w>k
inoremap <M-l> <C-w>l
vnoremap <M-h> <C-w>h
vnoremap <M-j> <C-w>j
vnoremap <M-k> <C-w>k
vnoremap <M-l> <C-w>l
tnoremap <M-h> <C-\><C-n><C-w>h
tnoremap <M-j> <C-\><C-n><C-w>j
tnoremap <M-k> <C-\><C-n><C-w>k
tnoremap <M-l> <C-\><C-n><C-w>l

if has("win32")
        set shell=powershell
        set shellcmdflag=\ -NoLogo\ -NoProfile\ -ExecutionPolicy\ RemoteSigned\ -Command
        set shellquote=\"
        set shellpipe=\|
        set shellredir=>
endif
