syntax on 
set number
set relativenumber 
set tabstop=4
set shiftwidth=4
set softtabstop=4 
set completeopt-=preview 
set smarttab
set expandtab 
set autoindent 
set termguicolors

call plug#begin()
	Plug 'jiangmiao/auto-pairs'
    Plug 'ctrlpvim/ctrlp.vim'
	Plug 'tpope/vim-commentary'
	Plug 'ycm-core/YouCompleteMe'
	Plug 'TheNiteCoder/mountaineer.vim'
call plug#end()

colorscheme mountaineer-grey
set t_Co=256

nnoremap <C-c> :tabclose<CR>
nnoremap <C-g> :tabnext<CR>
nnoremap <C-q> :q<CR>
nnoremap <C-s> :w<CR>
nnoremap <C-z> :wq<CR>
nnoremap <C-o> :Commentary<CR>
nnoremap <C-x> :YcmCompleter FixIt<CR>
nnoremap <C-f> :CtrlP <CR>
nnoremap <C-l> :lnext <CR>

let g:ycm_auto_trigger=1
let g:ycm_enable_semantic_highlighting=1
let g:ycm_clear_inlay_hints_in_insert_mode=1
let g:ycm_always_populate_location_list=1 "jump to errors
let g:ycm_echo_current_diagnostic="virtual-text"
call prop_type_add ('YCM_HL_bracket', {'highlight' : 'Normal'})

let g:ctrlp_custom_ignore = 'build'
