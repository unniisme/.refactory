let mapleader="\\"

set tabstop=4 expandtab shiftwidth=4 softtabstop=4

map <leader>s :w!<cr>
map <leader>q :q!<cr>
map <leader>w :wq!<cr>

set number 
se mouse+=a
set autoindent

" Cursors
let &t_SI = "\e[5 q"
let &t_EI = "\e[2 q"

"" Plugins
" 'altercation/vim-colors-solarized'
" 'vim-airline/vim-airline'
" 'preservim/nerdtree'

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

" CTRL-t is new tab.
nnoremap <C-t>     :tabnew<CR>
inoremap <C-t>     <Esc>:tabnew<CR>
" CTRL-Tab is next tab
noremap <C-Tab> :tabnext<CR>
inoremap <C-Tab> <Esc>:tabnext<CR>
cnoremap <C-Tab> <C-C>:tabnext<CR>
" CTRL-SHIFT-Tab is previous tab
noremap <C-S-Tab> :tabprevious<CR>
inoremap <C-S-Tab> <Esc>:tabprevious<CR>
cnoremap <C-S-Tab> <C-C>:tabprevious<CR>
