syntax on 

set number
" set hlsearch
set relativenumber 
set signcolumn=no    "no error message on the left
set tabstop=3
set shiftwidth=3
set softtabstop=3 
set completeopt-=preview 
set smarttab
set expandtab
set autoindent 
set mouse=a

set wildmenu               "auto complete in vim commands 
set clipboard=unnamed      "yank to clipboard (primary, use unnamedplus for clipboard)

call plug#begin()
   " Plug 'scrooloose/nerdcommenter',
   " Plug 'jiangmiao/auto-pairs'
   " Plug 'ctrlpvim/ctrlp.vim'
   " Plug 'godlygeek/tabular'
   
   Plug 'preservim/vim-markdown'
   Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
   Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
   Plug 'junegunn/fzf.vim'
   Plug 'tpope/vim-commentary'
   Plug 'ycm-core/YouCompleteMe'
   Plug 'morhetz/gruvbox'
   Plug 'mattn/emmet-vim'
call plug#end()

" MARKDOWN
set conceallevel=2
let g:mkdp_auto_start = 0
let g:vim_markdown_conceal = 2
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_autowrite = 1
let g:vim_markdown_math = 1
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_strikethrough = 1

let g:mkdp_theme = 'dark'
let g:mkdp_page_title = '${name}'
let g:mkdp_markdown_css = '$HOME/.config/my-configs/markdown.css'

set termguicolors
colorscheme gruvbox 

set bg=dark
set t_Co=256

command! -bang -nargs=* RG
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --colors "path:fg:176,113,111" --colors "line:fg:176,113,111" --smart-case '.shellescape(<q-args>), 1, {'options': '--color hl:#8AABAC '}, 0)


"mapping
let mapleader = " "
nnoremap <C-c> :tabclose<CR>
nnoremap <C-g> :tabnext<CR>
nnoremap <C-q> :q<CR>
nnoremap <C-s> :w<CR>
nnoremap <C-z> :YcmCompleter GoToDeclaration<CR>
nnoremap <C-o> :Commentary<CR>
nnoremap <C-x> :YcmCompleter FixIt<CR>
nnoremap <leader>a :YcmCompleter GoToAlternateFile<CR>
nnoremap <C-e> :ll <CR>             "fetch errors
nnoremap <C-l> :lnext <CR>          "jump to next error
nnoremap <C-k> :lprevious <CR>
nnoremap <leader>; :Buffers<CR>
nnoremap <leader>p :Files <CR>
nnoremap <leader>o :MarkdownPreview<CR>
nnoremap <leader>r :YcmRestartServer<CR>
nnoremap <leader>h :YcmCompleter GetDoc<CR>
nnoremap <leader>c :!compiledb make clean && compiledb -- make<CR>
nnoremap <C-p> :RG <CR>

let g:ycm_auto_trigger=1
let g:ycm_enable_semantic_highlighting=1
let g:ycm_clear_inlay_hints_in_insert_mode=1
let g:ycm_always_populate_location_list=1 "jump to errors
let g:ycm_echo_current_diagnostic = 'virtual-text'


call prop_type_add ('YCM_HL_bracket', {'highlight' : 'Normal'})
let g:mkdp_path_to_chrome = "qutebrowser"

hi Normal ctermbg=NONE guibg=NONE 

