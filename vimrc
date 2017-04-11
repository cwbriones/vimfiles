"======================================================================
" Plugins managed by vim-plug
"======================================================================
call plug#begin('~/.vim/bundle')

Plug 'ElmCast/elm-vim'
Plug 'Lokaltog/vim-easymotion'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Valloric/YouCompleteMe'
Plug 'bling/vim-airline'
Plug 'cespare/vim-toml'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'elixir-lang/vim-elixir'
Plug 'godlygeek/tabular'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdtree'
Plug 'w0rp/ale'
Plug 'sjl/gundo.vim'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-python/python-syntax'
" Plug 'eagletmt/ghcmod-vim'
" Plug 'eagletmt/neco-ghc'
" Plug 'tpope/vim-abolish'
" Plug 'vim-erlang/vim-erlang-compiler'
" Plug 'vim-erlang/vim-erlang-omnicomplete'

" Colorschemes
Plug 'chriskempson/base16-vim'
Plug 'mkarmona/colorsbox'
Plug 'morhetz/gruvbox'

call plug#end()
"======================================================================
" End Plugins
"======================================================================

" Custom Function Definitions
function! TogglePaste()
    if &paste == 1
        set nopaste
    else
        set paste
    endif
endfunction

function! ToggleToolbars()
    if &guioptions == 'aegimrLtT'
        set guioptions=aci
    else
        set guioptions=aegimrLtT
        set lines=60
        set columns=80
    endif
endfunction

function! ToggleFullScreen()
    if has("Mac")
        if &fu == 1
            set nofu
            set lines=50
            set columns=80
        else
            set fu
        endif
    else
        call ToggleToolbars()
        call system("wmctrl -i -r ".v:windowid." -b toggle,fullscreen")
   endif
    redraw
endfunction

" call matchadd('ColorColumn', '\%81v', 100)
function! ToggleColorColumn()
    if &colorcolumn == 101
        set colorcolumn=0
    else
        set colorcolumn=101
    endif
endfunction

" For easy editing of plain text
command! -nargs=* Plain set wrap linebreak nolist showbreak=…
vmap <D-j> gj
vmap <D-k> gk
vmap <D-4> g$
vmap <D-6> g^
nmap <D-j> gj
nmap <D-k> gk
nmap <D-4> g$
nmap <D-6> g^

" The Silver Searcher
let g:ctrlp_cmd="CtrlPCurWD"
if executable('rg')
    " Use rg in Ctrl-P for listing files and over grep.
    set grepprg=ag\ --nogroup\ --nocolor

    let g:ctrlp_user_command='ag %s -l --nocolor -g ""'
    let g:ctrlp_user_caching=1
endif

command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

" Automatically open NERDTree if no files specified
" autocmd vimenter * if !argc() | NERDTree | endif
let NERDTreeIgnore = ['\.pyc$']

"ale error checker settings
let g:ale_sign_error = '!!'
let g:ale_sign_warning = '>>'
let g:ale_lint_on_enter = 0
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_lint_on_text_changed = 'never'
let airline#extensions#ale#error_symbol = '⨉ '
let airline#extensions#ale#warning_symbol = '⚠ '
let g:airline#extensions#ale#enabled = 1

" Appearance
filetype on
" File specific mappings, found in ~/.vim/ftplugin
filetype plugin on
" Enable language specific indentation settings
filetype plugin indent on
syntax on

set encoding=utf-8
set fileformat=unix

set hidden
set foldenable
set foldlevel=99
let g:erlang_folding=1
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif
if has("nvim") && $TERM == 'xterm-256color'
  set termguicolors
endif
set nowrap
set ruler
set number
set bg=dark
set splitright
set splitbelow
" For use with airline status bar
if !exists("g:airline_symbols")
    let g:airline_symbols = {}
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    let g:airline_symbols.branch = ''
    let g:airline_symbols.readonly = ''
    let g:airline_symbols.paste = 'ρ'
    let g:airline_symbols.linenr = ''
    let g:airline_symbols.maxlinenr = ''
    let g:airline_symbols.whitespace = 'Ξ'
endif

set laststatus=2
let fullcolor_colorscheme="colorsbox-material"
" gui-specific font and colorscheme settings
if has("gui_running")
    set lines=60
    set columns=80

    if has("win32")
        set guifont=Consolas:h11
    elseif has("Mac")
        set guifont=Inconsolata\ for\ Powerline:h18
    else
        set guifont=Inconsolata\ for\ Powerline\ Bold\ 12
    endif
    execute "colorscheme ".fullcolor_colorscheme
    set guioptions=aegimrLtT
    "Put gvim into fullscreen"
    map <silent> <F11> :call ToggleFullScreen()<CR>
elseif has("nvim")
    execute "colorscheme ".fullcolor_colorscheme
else
    colorscheme jellybeans
endif

" Visual indicator of more than 80 columns changed to red
highlight ColorColumn ctermbg=red
highlight ColorColumn guibg=red

" Visual indicator of extraneous whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
command! Clean execute "%s/\\s\\+$//g"

" Global tab and indentation settings
" Show tabs with `list` attribute enabled
set lcs=tab:>-
" How many spaces a tab counts for
set tabstop=4
" how many columns to use when a tab is inserted
set softtabstop=4
" how many columns are indented with >> and <<, auto indent
set shiftwidth=4
set expandtab

set autoindent
set smarttab
set smartindent

" Allow backspaces in insert mode
set backspace=indent,eol,start

" Search settings
set incsearch
set hlsearch
set smartcase
set ignorecase
set history=1000 " Remember lots
set undolevels=1000

" I have git for this.
set nobackup
set noswapfile

set wildignore+=*.swp,*.back,*.pyc,*.class,*.beam
set title " change the title of the window
set visualbell " don't beep
set noerrorbells " don't beep
set cursorline

" Key mappings
let mapleader = ","
map  <leader>td <Plug>TaskList
nmap  <leader>a: :Tabularize /:<CR>
nmap  <leader>a= :Tabularize /=<CR>
vmap  <leader>a: :Tabularize /:<CR>
vmap  <leader>a= :Tabularize /=<CR>
vmap  <leader>a; :Tabularize /::<CR>
vmap  <leader>a- :Tabularize /-><CR>
nmap <silent> <leader>ff :CtrlP<CR>
nmap <silent> <leader>fb :CtrlPMRU<CR>
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
nnoremap <leader>f :CtrlP<CR>
nnoremap <leader>F :CtrlPCurWD<CR>
nnoremap <leader>w <C-w>v<C-w>l
" <F1> is mapped to vim help by the OS"
noremap <F2> :Errors<CR>
noremap <F3> :NERDTreeToggle<CR>
" Clear recent search
noremap <F5> :set hlsearch!<CR>
noremap <F6> :call ToggleColorColumn()<CR>
noremap <F7> :GundoToggle<CR>
inoremap jj <ESC>

noremap <leader>y "*y
noremap <leader>p "*p
noremap <leader>Y "+y
noremap <leader>P "+p

" ===================================================================
" Completion plugin settings
" ===================================================================
noremap <leader>d :YcmCompleter GetDoc<CR>
noremap <leader>g :YcmCompleter GoTo<CR>
noremap <leader>t :YcmCompleter GetType<CR>
noremap <leader>u :YcmCompleter GoToReferences<CR>
noremap <leader>fi :YcmCompleter FixIt<CR>

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

"YCM Settings"
let g:ycm_global_ycm_extra_conf = '~'
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_extra_conf_globlist = ['~', '.', '../']
let g:ycm_add_preview_to_completeopt=1
let g:ycm_python_binary_path='python'
set completeopt=menuone,preview
let pumheight=15

let g:ycm_rust_src_path=$RUST_SRC_PATH
