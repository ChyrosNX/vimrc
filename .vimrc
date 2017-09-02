set nocompatible    " Use vim settings instead of vi
set encoding=utf-8

""" gVim Font & Theme Settings
let g:nx_font_size="normal"         " small | normal | large | xlarge
let g:nx_theme_background="dark"    " light | dark
let g:nx_theme="solarized"

let g:nx_font_unix="Monospace Regular"
let g:nx_font_dos="Consolas"
let g:nx_font_mac="Monaco"

let g:nx_font_size_unix=10
let g:nx_font_size_dos=11
let g:nx_font_size_mac=12

""" Plugins (https://github.com/junegunn/vim-plug)
call plug#begin("~/.vim/plugged")
    Plug 'altercation/vim-colors-solarized' " General theme
    Plug 'vim-airline/vim-airline'          " Status and Tab line
    Plug 'vim-airline/vim-airline-themes'   " vim-airline theme
    Plug 'scrooloose/nerdtree'              " File system explorer
    Plug 'kien/ctrlp.vim'                   " Fuzzy file search, mru, etc
    Plug 'tpope/vim-fugitive'               " Git integration
    "Plug 'airblade/vim-gitgutter'           " Git diff signs
    Plug 'mhinz/vim-signify'                " Diff signs
    Plug 'tpope/vim-surround'               " Surround text w/ braces, etc
    Plug 'scrooloose/nerdcommenter'         " Comment functions
    Plug 'scrooloose/syntastic'             " Syntax-checking
    Plug 'majutsushi/tagbar'                " Class outline viewer
    Plug 'klen/python-mode'                 " Python plug-in
call plug#end()

function! NX_PimpMyVim()
    " Enhance VIM experience
    if has("gui_running")
        call NX_UpdateFontSize()    " Update font size based on settings

        " Ctrl+F2 - Change Background Theme
        nnoremap <C-F2> :call NX_ChangeBackgroundTheme()<CR>

        " Ctrl+F3 - Update Font Size
        nnoremap <C-F3> :call NX_UpdateFontSize()<CR>
    endif

    call NX_ApplyTheme()            " Apply color schemes (gVim only)
    call NX_SetTempDirectory()      " Set swap file directory
    call NX_EnablePersistentUndo()  " Persist undo forever
endfunction

""" Plugin Settings
filetype plugin on                          " Req'd for NERDCommenter
let g:airline#extensions#tabline#enabled=1  " Show Tab line
let NERDTreeShowHidden=1                    " Show hidden files (NERDTree)
let g:ctrlp_show_hidden=1                   " Show hidden files (CtrlP)
""" Tagbar...
if has("unix")
    " Unix/Mac - Install ctags in unix/mac via software package
    " and Tagbar will auto-locate the binary file
elseif has("win32")
    " Win32 - download binary from: http://ctags.sourceforge.net/
    " and put the contents inside the specified directory below:
    let g:tagbar_ctags_bin="~/.vim/plugged/ctags58/ctags.exe"
endif
""" python-mode...
let g:pymode_rope=0             " Disabled due to slow-caching issue
"let g:pymode_python="python3"  " python2 | python3
""" Syntastic...
set statusline+=%#warningmsg#               " Last given warning message
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list=1  " Fill loc-list with errors
let g:syntastic_auto_loc_list=1             " Open loc-list on errors
let g:syntastic_check_on_open=0             " Run syntax checks on open
let g:syntastic_check_on_wq=0               " Skips check on close
" NERDCommenter...
let g:NERDSpaceDelims=1             " Space after comment delimiter
let g:NERDDefaultAlign="left"       " Align when inserting a comment
let g:NERDCustomDelimiters={
    \     "c"     : { "left": "/**","right": "*/" }
    \     , "java": { "left": "/**","right": "*/" }
    \ }
let g:NERDCommentEmptyLines=1       " Include empty lines when commenting
let g:NERDTrimTrailingWhitespace=1  " Uncommenting removes trailing spaces

""" VIM Settings
set autoread                    " Auto reload file changes, if any
set backspace=indent,eol,start  " Make <BS> more useful
set clipboard=unnamed           " Use gui-clipboard instead

set tabstop=4                   " Number of spaces for <Tab>
set shiftwidth=4                " Number of spaces for << and >>
set expandtab                   " Use spaces instead of a tab
set autoindent                  " Copy indent to the next line
set smartindent                 " Language-specific auto-indentation

set autochdir                   " Auto change dir based on the open file
set number                      " Show line numbers
syntax on                       " Enable syntax highlighting

set ignorecase                  " Ignore-case searching
set hlsearch                    " Enable search highlighting
set incsearch                   " Enable incremental search

""" Platform-specific Settings
if has("unix")
    set shell=bash\ -i          " Source .bashrc environment
endif

""" Mappings
let mapleader="\\"

""" python-mode Mappings
let g:pymode_rope_goto_definition_bind="<A-g>"  " Alt+G -> Goto-definition

""" Unmap some navigation keys
noremap <Up>    :echo "One does not simply 'go up' with Arrow Keys."<CR>
noremap <Down>  :echo "One does not simply 'go down' with Arrow Keys."<CR>
noremap <Left>  :echo "One does not simply 'go left' with Arrow Keys."<CR>
noremap <Right> :echo "One does not simply 'go right' with Arrow Keys."<CR>
noremap <BS>    <nop>
noremap <Space> <nop>

""" Map Ctrl+H/J/K/L for navigating other buffers used by some plugins
nnoremap <C-j> <Up>
nnoremap <C-k> <Down>
nnoremap <C-h> <Left>
nnoremap <C-l> <Right>

""" Map Ctrl+ArrowKeys for changing window size
nnoremap <C-Up>    :res +5<CR>
nnoremap <C-Down>  :res -5<CR>
nnoremap <C-Left>  :vert res -5<CR>
nnoremap <C-Right> :vert res +5<CR>

nnoremap <C-S-Up>    :res +1<CR>
nnoremap <C-S-Down>  :res -1<CR>
nnoremap <C-S-Left>  :vert res -1<CR>
nnoremap <C-S-Right> :vert res +1<CR>

" Alt+1 Custom NERDTree Toggle
nnoremap <A-1>      :call NX_NERDTreeToggle()<CR>
inoremap <A-1> <Esc>:call NX_NERDTreeToggle()<CR>

" Alt+2 TagbarToggle
nnoremap <A-2>      :TagbarToggle<CR>
inoremap <A-2> <Esc>:TagbarToggle<CR>

" Alt+[X|Z] Next/Prev Tab
nnoremap <A-x>      :tabn<CR>
inoremap <A-x> <Esc>:tabn<CR>
nnoremap <A-z>      :tabp<CR>
inoremap <A-z> <Esc>:tabp<CR>

" Ctrl+N New Tab
nnoremap <C-n>      :tabnew<CR>
inoremap <C-n> <Esc>:tabnew<CR>

" Alt+C - Close Current Tab
nnoremap <A-c>      :q<CR>
inoremap <A-c> <Esc>:q<CR>

" Alt+Q - Close Current Tab Without Saving!
nnoremap <A-q>      :q!<CR>
inoremap <A-q> <Esc>:q!<CR>

" Shift+Alt+C - Close Other Tabs
nnoremap <A-C>      :tabonly<CR>
inoremap <A-C> <Esc>:tabonly<CR>

" Alt+[J|K] - Move lines up/down
nnoremap <A-j>      :m . +1<CR>
inoremap <A-j> <Esc>:m . +1<CR>
nnoremap <A-k>      :m . -2<CR>
inoremap <A-k> <Esc>:m . -2<CR>

" Ctrl+S - Save File
nnoremap <C-s>      :w<CR>
inoremap <C-s> <Esc>:w<CR>

""" Speed Mappings
" Leader+r - Find and replace all with confirm
nnoremap <Leader>r yiw:%s/*//g<Left><Left>
" Leader+R - Find and replace all
nnoremap <Leader>R yiw:%s/*//gc<Left><Left><Left>
" Leader+c - Count all from buffer with (Requires value in register *)
nnoremap <Leader>c yiw:%s/*//gn<CR>

""" Custom functions
function! NX_ApplyTheme()
    " Apply color schemes (gVim only)
    if has("gui_running")
        let &background=g:nx_theme_background
        let cmd_colorscheme="colorscheme " . g:nx_theme
        execute cmd_colorscheme
        let g:airline_theme=g:nx_theme
    else
        set background=dark
    endif
endfunction

function! NX_SetTempDirectory()
    " Set swap file directory
    let temp_dir=NX_CreateTempDir("temp")
    let &directory=temp_dir
endfunction

function! NX_EnablePersistentUndo()
    " Persist undo forever
    let undo_dir=NX_CreateTempDir("undo")
    let &undodir=undo_dir
    set undofile
endfunction

function! NX_NERDTreeToggle()
    " Check if NERDTree window is visible in the current tabpage
    if exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1
        :NERDTreeClose
    else
        :NERDTreeCWD
    endif
endfunction

function! NX_CreateTempDir(directory)
    " Create temp directory and return its path
    let temp_dir="/.vim/tmp/" . a:directory
    if has("unix")
        let temp_dir=expand("~") . temp_dir
        call system("mkdir -p " . temp_dir)
    elseif has("win32")
        let temp_dir=expand("~") . substitute(temp_dir, "/", "\\", "g")
        call system("mkdir " . temp_dir)
    endif
    return temp_dir
endfunction

""" gVim-only Functions
if has("gui_running")
    function! NX_ChangeBackgroundTheme()
        " Apply color schemes
        if &background == "light"
            set background=dark
        else
            set background=light
        endif
    endfunction

    function! NX_UpdateFontSize()
        " Update font size based on settings
        if g:nx_font_size == "small"
            let g:nx_szmod=-2
            let g:nx_font_size="normal"
        elseif g:nx_font_size == "normal"
            let g:nx_szmod=0
            let g:nx_font_size="large"
        elseif g:nx_font_size == "large"
            let g:nx_szmod=2
            let g:nx_font_size="xlarge"
        elseif g:nx_font_size == "xlarge"
            let g:nx_szmod=4
            let g:nx_font_size="small"
        endif

        if has("gui_gtk")
            let &guifont=g:nx_font_unix . " " .
                \ (g:nx_font_size_unix + g:nx_szmod)
        elseif has("gui_win32")
            let &guifont=g:nx_font_dos . ":h" .
                \ (g:nx_font_size_dos + g:nx_szmod)
        elseif has("gui_macvim")
            let &guifont=g:nx_font_mac . ":h" .
                \ (g:nx_font_size_mac + g:nx_szmod)
        endif
    endfunction
endif

call NX_PimpMyVim()

