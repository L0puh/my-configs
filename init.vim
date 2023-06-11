syntax on
set number
set relativenumber
set mouse=a
set termguicolors

set tabstop=4 
set shiftwidth=4
set smarttab
set expandtab 
set softtabstop=4 
set autoindent 

set novisualbell
set wrap
set linebreak
set visualbell t_vb=
set splitbelow

call plug#begin()
Plug 'jiangmiao/auto-pairs'
Plug 'christoomey/vim-tmux-navigator' "for tmux
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

"coloschemes 
Plug 'morhetz/gruvbox'
Plug 'ajmwagar/vim-deus'
Plug 'kristijanhusak/vim-hybrid-material'

Plug 'vim-airline/vim-airline-themes' "airline
Plug 'vim-airline/vim-airline' 

Plug 'ryanoasis/vim-devicons'
Plug 'preservim/nerdtree' 

Plug 'mattn/emmet-vim' 
Plug 'tpope/vim-surround'  
Plug 'tpope/vim-commentary' "comments (ctrl + o) 


Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'Valloric/YouCompleteMe'

call plug#end()

let g:ycm_auto_trigger=1
let g:ycm_enable_semantic_highlighting=1
let g:ycm_clear_inlay_hints_in_insert_mode=1

colorscheme gruvbox
set background=dark
let g:gruvbox_contrast = "normal"
let g:gruvbox_number_column=1
let python_highlight_all=1

"preference for transp bg in the terminal
hi NonText ctermbg=none
hi Normal guibg=NONE ctermbg=NONE
hi LineNr guibg=NONE ctermbg=NONE
hi SignColumn guibg=NONE ctermbg=NONE

"mapping
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-t> :tabnew<CR>
nnoremap <C-c> :tabclose<CR>
nnoremap <C-g> :tabnext<CR>
nnoremap <C-q> :q<CR>
nnoremap <C-s> :w<CR>
nnoremap <C-z> :wq<CR>
nnoremap <C-o> :Commentary<CR>
nnoremap <C-f> :Files<CR>
nnoremap <C-b> :BLines<CR>
nnoremap <C-p> :Rg <CR>

" air-line
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#enabled = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_theme = 'gruvbox'

let g:webdevicons_enable_airline_tabline = 1

" adding to vim-airline's statusline
let g:webdevicons_enable_airline_statusline = 1
let g:webdevicons_enable_airline_statusline = 1

" whether or not to show the nerdtree brackets around flags
let g:webdevicons_conceal_nerdtree_brackets = 1


