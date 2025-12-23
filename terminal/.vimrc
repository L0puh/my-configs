syntax on 
set number
set nocompatible

" set hlsearch
set mouse=a
set relativenumber 
set signcolumn=no          " no error message on the left bar 
set tabstop=3
set shiftwidth=3
set softtabstop=3 
set completeopt-=preview 
set smarttab
set expandtab
set autoindent 
set linebreak wrap
set tw=75                  " break line into multiple smaller
set wildmenu               " auto complete in vim commands 

"yank to clipboard ("primary - unnamed, unnamedplus - clipboard)
" set clipboard=unnamed


call plug#begin()

   Plug 'morhetz/gruvbox'
   Plug 'junegunn/fzf.vim'
   Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

   Plug 'godlygeek/tabular'
   Plug 'preservim/vim-markdown'
   Plug 'tpope/vim-commentary'
   Plug 'ycm-core/YouCompleteMe'
   Plug 'itchyny/lightline.vim'
   Plug 'ctrlpvim/ctrlp.vim'

"LATEX
   Plug 'lervag/vimtex'
   Plug 'sirver/ultisnips'
   Plug 'honza/vim-snippets'

"MARKDOWN
   Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

call plug#end()


" MARKDOWN
set conceallevel=2
let g:vim_markdown_conceal = 2
let g:vim_markdown_folding_disabled = 0
let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_autowrite = 1
let g:vim_markdown_math = 1
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_edit_url_in = 'vsplit'

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
             \ 'out_dir' : '.texfiles',
             \ 'options' : [
             \    '-shell-escape',
             \    '-verbose',
             \    '-file-line-error',
             \    '-synctex=1',
             \    '-interaction=nonstopmode',
             \ ],
             \}

"YouCompleteMe
let g:ycm_auto_trigger=1
let g:ycm_enable_semantic_highlighting=1
let g:ycm_clear_inlay_hints_in_insert_mode=1
let g:ycm_always_populate_location_list=1 "jump to errors
let g:ycm_echo_current_diagnostic = 'virtual-text'
call prop_type_add ('YCM_HL_bracket', {'highlight' : 'Normal'})


"FZF
command! -bang -nargs=* RG call fzf#vim#grep(
        \   'rg
        \ --column
        \ --line-number
        \ --no-heading
        \ --fixed-strings
        \ --ignore-case
        \ --hidden
        \ --ignore-dot
        \ --follow
        \ --glob "!.git/*"
        \ --glob "!libs/*"
        \ --glob "!build/*"
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
    elseif a:lines[1] == 'ctrl-t' && !empty(a:lines[1]) |
      execute 'tabnew ' . split(a:lines[2], '#####')[0]                     
    elseif len(a:lines) == 2 || !empty(a:lines[1]) |                      
      execute 'edit ' . a:lines[0]                                        
    else                                                                  
      execute 'edit ' . split(a:lines[2], '#####')[0]                     
    endif                                                                 
  endfunction                                                                                                      
  let l:spec = {                                                          
        \'options': ['-d=#####', '--print-query', '--expect=ctrl-t'],     
        \'sink*': funcref('s:FzfFileAccept')                              
        \}                                                                
  call fzf#vim#files(getcwd(), fzf#vim#with_preview(l:spec), a:fullscreen)
endfunction


function! InsertLaTeXTemplate()
    if line('$') == 1 && getline(1) == ''
        execute '0r ~/.config/my-configs/template.tex'
    endif
endfunction

function! GenerateRunScript()
    let l:filename=expand("%")
    let l:filetype=&filetype
    let l:name=expand("%<")
    let l:current_dir = fnamemodify(getcwd(), ":t")
      
    if l:filetype == 'python'
        let l:command = 'python ' . l:filename
    elseif l:filetype == 'sh'
        let l:command = 'bash ' . l:filename
    elseif l:filetype == 'cpp'
        let l:command = 'g++ ' . l:filename . " -o " . l:name . ".out && ./" . l:name . ".out"
    elseif l:filetype == 'c'
        let l:command = 'gcc ' . l:filename . " -o " . l:name .  ".out && ./" . l:name . ".out"
    else
        echo "No run command defined for this filetype"
        return
    endif
   
    if l:current_dir == 'train'
       let l:command = l:command . ' < test.txt'
    endif
    
    call writefile([l:command], 'run.sh')
    echo "run.sh created." 
endfunction
function! RunScript()
  belowright terminal bash -c "bash run.sh"
endfunction

autocmd BufNewFile *.tex call InsertLaTeXTemplate() " paste template when open empty latex file
command! -bang Files :call FzfFiles(<bang>0)        " custom fzf function to open new files

let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/libs/*,*/build/*,build/*,*/test/*,*/assets/*,*/media/*,libs/*,*/android_sdk/*
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git,build,test,assets,android_sdk,myapp)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }

" MAPPINGS
let mapleader = " "
nnoremap <C-q> :q<CR>
nnoremap <C-s> :w<CR>
nnoremap <C-e> :ll <CR>

nnoremap <C-x>     :YcmCompleter FixIt<CR>
nnoremap <leader>d :rightbelow vertical YcmCompleter GoToDeclaration<CR>
nnoremap <leader>a :rightbelow vertical YcmCompleter GoToAlternateFile<CR>
nnoremap ;r :YcmCompleter GoToReferences<CR>
nnoremap ;d :YcmCompleter GoToDefinition<CR>

nnoremap <leader>g  :call GenerateRunScript() <CR>
autocmd FileType tex      nnoremap <buffer> <leader>t :VimtexTocToggle<CR> 
autocmd FileType tex      nnoremap <buffer> <leader>c :VimtexClean<CR>
autocmd FileType tex      nnoremap <buffer> <leader>o :VimtexCompile<CR>
autocmd FileType markdown nnoremap <buffer> <leader>o :MarkdownPreview<CR>
autocmd FileType markdown nnoremap <buffer> <leader>O :belowright terminal convert_md %<CR>
autocmd FileType cpp      nnoremap <buffer> <leader>er :call RunScript() <CR>
autocmd FileType c        nnoremap <buffer> <leader>er :call RunScript() <CR>
autocmd FileType python   nnoremap <buffer> <leader>er :call RunScript() <CR>
autocmd FileType python   nnoremap <buffer> <leader>ep :belowright terminal python %<CR>
autocmd FileType go       nnoremap <buffer> <leader>er :belowright terminal go run .<CR>

" nnoremap <silent> <leader>p  :execute 'silent! noa'<Bar>:call FzfFiles(0)<CR>

"switch without writing 
nnoremap <silent> <leader>r  :execute 'silent! w'<Bar>RG <CR> 
nnoremap <silent> <leader>p  :execute 'silent! w'<Bar>CtrlP<CR> 
nnoremap <silent> <leader>P  :execute 'silent! w'<Bar>CtrlP<CR> 
nnoremap <silent> <leader>k  :Termdebug %<.out<CR> 


map Q gq
map <leader>H K
map <leader>h :YcmCompleter GetDoc <CR>
map <leader>J :join <CR>
map J :tabnext<CR>
map <C-c> gc

" copy selected text to clipboard
vnoremap t :w !xclip -i -sel c<CR> 

" zfap 
set foldmethod=manual
nnoremap <space> za

" DEBUGGING  (load via leader-K)
packadd! termdebug
let g:termdebug_config = {}
let g:termdebug_config['wide']=1
let g:termdebug_config['disasm_window']=v:false
let g:termdebug_config['disasm_height']=5

" COLORS
let g:lightline = {'colorscheme': 'gruvbox'}
set laststatus=2
set noshowmode
set termguicolors
set bg=dark
set t_Co=256
set background=dark

colorscheme gruvbox 
hi Terminal ctermbg=NONE guibg=NONE
hi Normal ctermbg=NONE guibg=NONE

