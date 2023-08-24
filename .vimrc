syntax on 
set number
set relativenumber 
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab 
set softtabstop=4 
set autoindent 


call plug#begin()
	" EDITOR
	Plug 'jiangmiao/auto-pairs'
	Plug 'preservim/nerdtree' 
	Plug 'tpope/vim-commentary'
	" AUTOSUGGEST 
	Plug 'ycm-core/YouCompleteMe'
	
	" COLORS
	Plug 'TheNiteCoder/mountaineer.vim'
    Plug 'sjl/badwolf'
call plug#end()


let g:ycm_auto_trigger=1
let g:ycm_enable_semantic_highlighting=1
let g:ycm_clear_inlay_hints_in_insert_mode=1
let g:ycm_echo_current_diagnostic="virtual-text"

colorscheme badwolf

nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-c> :tabclose<CR>
nnoremap <C-g> :tabnext<CR>
nnoremap <C-q> :q<CR>
nnoremap <C-s> :w<CR>
nnoremap <C-z> :wq<CR>
nnoremap <C-o> :Commentary<CR>
nnoremap <C-x> :YcmCompleter FixIt<CR>

" hi NonText ctermbg=none
" hi Normal guibg=NONE ctermbg=NONE
" hi LineNr guibg=NONE ctermbg=NONE
" hi SignColumn guibg=NONE ctermbg=NONE
