set tabstop=3
set softtabstop=3
set expandtab
set shiftwidth=3
set number
set encoding=utf-8
set hlsearch
set incsearch
set ignorecase
set smartcase
map <CR> :noh<CR>
" set cursorline
" set cursorcolumn
set title

call plug#begin('~/.config/nvim/plugged')

" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"    let g:deoplete#enable_at_startup = 1
"    inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

Plug 'lifepillar/vim-solarized8'
Plug 'tomasr/molokai'
Plug 'sheerun/vim-polyglot'

Plug 'neomake/neomake'
   augroup localneomake
      autocmd! BufWritePost * Neomake
   augroup END
   let g:neomake_markdown_enabled_makers = []

   let g:neomake_elixir_enabled_makers = ['mycredo']
   function! NeomakeCredoErrorType(entry)
      if a:entry.type ==# 'F'
         let l:type = 'W'
      elseif a:entry.type ==# 'D'
         let l:type = 'I'
      elseif a:entry.type ==# 'W'
         let l:type = 'W'
      elseif a:entry.type ==# 'R'
         let l:type = 'I'
      elseif a:entry.type ==# 'C'
         let l:type = 'W'
      else
         let l:type = 'M'
      endif
      let a:entry.type = l:type
   endfunction

   let g:neomake_elixir_mycredo_maker = {
        \ 'exe': 'mix',
        \ 'args': ['credo', 'list', '%:p', '--format=oneline'],
        \ 'errorformat': '[%t] %. %f:%l:%c %m,[%t] %. %f:%l %m',
        \ 'postprocess': function('NeomakeCredoErrorType')
        \ }

Plug 'c-brenn/phoenix.vim'
Plug 'tpope/vim-projectionist'
Plug 'slashmili/alchemist.vim'
Plug 'powerman/vim-plugin-AnsiEsc'

call plug#end()

syntax enable
colorscheme solarized8_light
