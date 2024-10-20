
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
set clipboard=unnamed      "yank to clipboard 
                           "primary - unnamed, unnamedplus - clipboard

call plug#begin()
  
   Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
   Plug 'junegunn/fzf.vim'
   Plug 'tpope/vim-commentary'
   Plug 'ycm-core/YouCompleteMe'
   Plug 'morhetz/gruvbox'
   Plug 'mattn/emmet-vim'

"MARKDOWN
   Plug 'godlygeek/tabular'
   Plug 'preservim/vim-markdown'
   Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

call plug#end()

" MARKDOWN
set conceallevel=2
let g:vim_markdown_conceal = 2
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_autowrite = 1
let g:vim_markdown_math = 1
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_frontmatter = 1

let g:mkdp_auto_start = 0
let g:mkdp_theme = 'dark'
let g:mkdp_path_to_chrome = "qutebrowser"
let g:mkdp_page_title = '${name}'
let g:mkdp_markdown_css = '$HOME/.config/my-configs/markdown.css'
let g:mkdp_open_ip = ''


set termguicolors
set background=dark
colorscheme gruvbox 

set bg=dark
set t_Co=256

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

" errors:
nnoremap <C-e> :ll <CR>             "fetch errors
nnoremap <C-l> :lnext <CR>          "jump to next error
nnoremap <C-k> :lprevious <CR>
nnoremap <C-p>r :YcmRestartServer<CR>

nnoremap <leader>o :MarkdownPreview<CR>
nnoremap <leader>h :YcmCompleter GetDoc<CR>
nnoremap <leader>c :!compiledb make clean && compiledb -- make<CR>

" find files
nnoremap <leader>b :Buffers<CR>
nnoremap <silent> <leader>p  :execute 'silent! write'<Bar>FZF<CR>
nnoremap <silent> <leader>r  :execute 'silent! write'<Bar>RG <CR>

let g:ycm_auto_trigger=1
let g:ycm_enable_semantic_highlighting=1
let g:ycm_clear_inlay_hints_in_insert_mode=1
let g:ycm_always_populate_location_list=1 "jump to errors
let g:ycm_echo_current_diagnostic = 'virtual-text'



call prop_type_add ('YCM_HL_bracket', {'highlight' : 'Normal'})


command! -bang -nargs=* RG call fzf#vim#grep(
        \   'rg
        \ --column
        \ --line-number
        \ --no-heading
        \ --fixed-strings
        \ --ignore-case
        \ --hidden
        \ --follow
        \ --glob "!.git/*"
        \ --color "always"
        \ --colors "path:fg:176,113,111"
        \ --colors "line:fg:176,113,111"
        \ --smart-case '.shellescape(<q-args>),  
        \   fzf#vim#with_preview('right:50%:hidden', '?'),  <bang>0)


hi Normal ctermbg=NONE guibg=NONE 
