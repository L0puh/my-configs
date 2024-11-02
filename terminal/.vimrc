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

"yank to clipboard 
"primary - unnamed, unnamedplus - clipboard
set clipboard=unnamedplus

call plug#begin()
   Plug 'mattn/emmet-vim'
   Plug 'morhetz/gruvbox'
  
   Plug 'junegunn/fzf.vim'
   Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
   Plug 'tpope/vim-commentary'
   Plug 'ycm-core/YouCompleteMe'
   
"LATEX
   Plug 'lervag/vimtex'
   Plug 'SirVer/ultisnips'
   Plug 'honza/vim-snippets'


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
let g:mkdp_markdown_css = $HOME."/.config/my-configs/markdown.css"
let g:mkdp_open_ip = ''


"LATEX
filetype plugin indent on
let g:UltiSnipsExpandTrigger = '<c-l>'
let g:UltiSnipsSnippetDirectories=[$HOME."/.config/my-configs/snippets", "UltiSnips"]

let g:tex_flavor='latex'
let g:tex_conceal='abdmg'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
let g:vimtex_compiler_latexmk = {
            \ 'out_dir' : 'texfiles',
            \}


set termguicolors
set background=dark
colorscheme gruvbox 

set bg=dark
set t_Co=256

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

" create a file when none is found 
function! FzfFiles(fullscreen)                                            
  function! s:FzfFileAccept(lines) abort                                  
    if len(a:lines) < 2                                                   
      return                                                              
    elseif len(a:lines) == 2 || !empty(a:lines[1]) |                      
      execute 'edit ' . a:lines[0]                                        
    else                                                                  
      execute 'edit ' . split(a:lines[2], '#####')[0]                     
    endif                                                                 
  endfunction                                                                                                      
  let l:spec = {                                                          
        \'options': ['-d=#####', '--print-query', '--expect=ctrl-j'],     
        \'sink*': funcref('s:FzfFileAccept')                              
        \}                                                                
  call fzf#vim#files(getcwd(), fzf#vim#with_preview(l:spec), a:fullscreen)
endfunction

command! -bang Files :call FzfFiles(<bang>0)

" paste template when open empty latex file
autocmd BufNewFile *.tex call InsertLaTeXTemplate()

function! InsertLaTeXTemplate()
    if line('$') == 1 && getline(1) == ''
        execute '0r ~/.config/my-configs/template.tex'
    endif
endfunction

"mappings
let mapleader = " "
nnoremap <C-q> :q<CR>
nnoremap <C-s> :w<CR>
nnoremap <C-c> :tabclose<CR>
nnoremap <C-g> :tabnext<CR>
nnoremap <C-o> :Commentary<CR>

nnoremap <C-e>:ll <CR>
nnoremap <C-x>     :YcmCompleter FixIt<CR>
nnoremap <C-z>     :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>a :YcmCompleter GoToAlternateFile<CR>
nnoremap <leader>h :YcmCompleter GetDoc<CR>

autocmd FileType tex      nnoremap <buffer> <leader>t :VimtexTocToggle<CR> 
autocmd FileType tex      nnoremap <buffer> <leader>c :VimtexClean<CR>
autocmd FileType tex      nnoremap <buffer> <leader>o :VimtexCompile<CR>
autocmd FileType markdown nnoremap <buffer> <leader>o :MarkdownPreview<CR>

" nnoremap <leader>c :!compiledb make clean && compiledb -- make<CR>
nnoremap <leader>c :!sh run.sh<CR>

nnoremap <leader>b :Buffers<CR>
nnoremap <silent> <leader>p  :execute 'silent! write'<Bar>:call FzfFiles(0)<CR>
nnoremap <silent> <leader>r  :execute 'silent! write'<Bar>RG <CR>

hi Normal ctermbg=NONE guibg=NONE 
