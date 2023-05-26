let mapleader="\\"

set colorcolumn=89
set tabstop=3 expandtab shiftwidth=3 softtabstop=3

map <leader>s :w!<cr>
map <leader>q :q!<cr>
map <leader>w :wq!<cr>

" set number 
set cursorline
set autoindent


call plug#begin()
Plug 'altercation/vim-colors-solarized'
Plug 'catppuccin/nvim'
Plug 'vim-airline/vim-airline'
call plug#end()

syntax enable
set background=dark
let g:solarized_termcolors=256
colorscheme solarized 

" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

