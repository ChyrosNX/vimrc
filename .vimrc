set nocompatible    " Take advantage of Vim features
set encoding=utf-8
filetype plugin on  " Handle filetype-specific files when opened


""" README (for first time users)
"
" - This .vimrc uses vim-plug. To auto-install vim-plug:
"       1) download 'plug.vim' from https://github.com/junegunn/vim-plug
"       2) put downloaded file to your ~/.vim/ directory
"       3) start/restart your Vim.
"
"""


""" gVim Font & Theme Settings
" User Theme Settings
let g:nx_font_size = "normal"       " small | normal | large | xlarge
let g:nx_theme_background = "dark"  " light | dark
let g:nx_theme = "solarized"
" Font Name
let g:nx_font_unix = "Monospace Regular"
let g:nx_font_dos = "Consolas"
let g:nx_font_mac = "Monaco"
" Base Font Size
let g:nx_font_size_unix = 10
let g:nx_font_size_dos = 11
let g:nx_font_size_mac = 12


""" Misc
function! NX_mkdir(dir)
    """ Create directory
    if has("unix")
        call system("mkdir -p " . a:dir)
    elseif has("win32")
        call system("mkdir " . NX_to_win32_dir(a:dir))
    endif
endfunction

function! NX_cp(src, dest)
    """ Copy file
    if has("unix")
        call system("cp " . a:src . " " . a:dest)
    elseif has("win32")
        call system("copy /Y " . NX_to_win32_dir(a:src) . " " .
            \ NX_to_win32_dir(a:dest))
    endif
endfunction

function! NX_to_win32_dir(unix_dir)
    """ Convert unix directory to win32 directory
    return expand(substitute(a:unix_dir, "/", "\\", "g"))
endfunction

function! NX_has_plugin(name)
    for plugin in g:nx_enabled_plugins
        let plugin_name = strpart(
            \     plugin
            \     , strridx(plugin, '/', strlen(plugin)) + 1
            \     , strlen(plugin)
            \ )
        if plugin_name == a:name
            let plugin_dir = g:nx_plugin_dir . "/" . plugin_name
            return exists(glob(plugin_dir))
        endif
    endfor
endfunction

" Auto-install vim-plug
let g:nx_install_plugins = 0
if has("unix")
    let g:nx_autoload_dir = "~/.vim/autoload/"
    let g:nx_install_plugins = 1
elseif has("win32")
    let g:nx_autoload_dir = "~/vimfiles/autoload/"
    let g:nx_install_plugins = 1
endif

if empty(glob(g:nx_autoload_dir . "plug.vim"))
    if (!empty(glob("~/.vim/plug.vim")))
        call NX_mkdir(g:nx_autoload_dir)
        call NX_cp("~/.vim/plug.vim", g:nx_autoload_dir . "plug.vim")
    endif
endif

""" Plugin List
" Comment/uncomment to enable/disable plugins
let g:nx_enabled_plugins = []
call add(g:nx_enabled_plugins, 'altercation/vim-colors-solarized')
" status and tab line
call add(g:nx_enabled_plugins, 'vim-airline/vim-airline')
" vim-airline theme
call add(g:nx_enabled_plugins, 'vim-airline/vim-airline-themes')
" file system explorer
call add(g:nx_enabled_plugins, 'scrooloose/nerdtree')
" fuzzy file search, mru, etc
call add(g:nx_enabled_plugins, 'kien/ctrlp.vim')
" git integration
call add(g:nx_enabled_plugins, 'tpope/vim-fugitive')
" git diff signs
call add(g:nx_enabled_plugins, 'airblade/vim-gitgutter')
" vcs diff signs
call add(g:nx_enabled_plugins, 'mhinz/vim-signify')
" surround text w/ braces, etc
call add(g:nx_enabled_plugins, 'tpope/vim-surround')
" comment functions
call add(g:nx_enabled_plugins, 'scrooloose/nerdcommenter')
" syntax-checking
call add(g:nx_enabled_plugins, 'scrooloose/syntastic')
" class outline viewer
call add(g:nx_enabled_plugins, 'majutsushi/tagbar')
" python plug-in
call add(g:nx_enabled_plugins, 'klen/python-mode')


let g:nx_plugin_dir    = "~/.vim/plugged"

let nx_has_vim_plug    = !empty(glob(g:nx_autoload_dir . "plug.vim"))
let nx_has_ctags_bin   = !empty(glob(g:nx_plugin_dir . "/ctags/ctags.exe"))

""" Plugins
if nx_has_vim_plug
    call plug#begin(g:nx_plugin_dir)
    for plugin in nx_enabled_plugins
        Plug plugin
    endfor
    call plug#end()
endif

function! NX_PimpMyVim()
    """ Enhance VIM experience
    if has("gui_running")
        call NX_UpdateFontSize()    " Update font size

        " Ctrl+F2 - Change Background Theme
        nnoremap <C-F2> :call NX_ChangeBackgroundTheme()<CR>

        " Ctrl+F3 - Update Font Size
        nnoremap <C-F3> :call NX_UpdateFontSize()<CR>
    endif

    call NX_ApplyTheme()            " Apply color schemes
    call NX_SetTempDirectory()      " Set swap file directory
    call NX_EnablePersistentUndo()  " Persist undo forever
endfunction

""" Plugin Settings
if NX_has_plugin('vim-airline')
    " Show window tabs on top
    let g:airline#extensions#tabline#enabled = 1
endif
if NX_has_plugin('nerdtree')
    " Show hidden files in NERDTree
    let NERDTreeShowHidden = 1
endif
if NX_has_plugin('ctrlp.vim')
    " Show hidden files in Ctrlp
    let g:ctrlp_show_hidden = 1
endif
if NX_has_plugin('tagbar')
    if has("unix")
        " NOTE: install ctags using OS software package
    elseif has("win32") && nx_has_ctags_bin
        " NOTE: download binary from: http://ctags.sourceforge.net/
        " and put the contents at ~/.vim/plugged/ctags
        let g:tagbar_ctags_bin = "~/.vim/plugged/ctags/ctags.exe"
    endif
endif
if NX_has_plugin('python-mode')
    let g:pymode_rope = 0               " Disabled due to slow-caching issue
    "let g:pymode_python = "python3"    " python2 | python3
endif
if NX_has_plugin('syntastic')
    """ Syntastic...
    set statusline+=%#warningmsg#                   " Last given warning message
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*
    let g:syntastic_always_populate_loc_list = 1    " Fill loc-list with errors
    let g:syntastic_auto_loc_list = 1               " Open loc-list on errors
    let g:syntastic_check_on_open = 0               " Run syntax checks on open
    let g:syntastic_check_on_wq = 0                 " Skips check on close
endif
if NX_has_plugin('nerdcommenter')
    let g:NERDSpaceDelims = 1               " Space after comment delimiter
    let g:NERDDefaultAlign = "left"         " Align when inserting a comment
    let g:NERDCustomDelimiters = {
        \     "c"     : { "left": "/**","right": "*/" }
        \     , "java": { "left": "/**","right": "*/" }
        \ }
    let g:NERDCommentEmptyLines = 1         " Include empty lines when commenting
    let g:NERDTrimTrailingWhitespace = 1    " Uncommenting removes trailing spaces
endif

""" VIM Settings
set autoread                    " Auto reload file changes, if any
set backspace=indent,eol,start  " Make <BS> more useful
set clipboard=unnamed           " Use gui-clipboard instead

" Tabstops and Indentions
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
let mapleader = "\\"

""" python-mode Mappings
let g:pymode_rope_goto_definition_bind = "<A-g>"  " Alt+G -> Goto-definition

""" Unmap navigation keys
noremap <Up>      :echo "One does not simply 
    \ 'go up' with Arrow Keys."<CR>
noremap <Down>    :echo "One does not simply
    \ 'go down' with Arrow Keys."<CR>
noremap <Left>    :echo "One does not simply
    \ 'go left' with Arrow Keys."<CR>
noremap <Right>   :echo "One does not simply
    \ 'go right' with Arrow Keys."<CR>
nnoremap <Space>   <nop>
nnoremap <S-Space> <nop>
nnoremap <C-Space> <nop>
noremap <BS>   <nop>
noremap <S-BS> <nop>
noremap <C-BS> <nop>

""" Map jk to exit insert mode
inoremap jk <Esc>

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

" F9 Change FileFormat DOS <-> UNIX
nnoremap <F9>      :call NX_ChangeFileFormat()<CR>
inoremap <F9> <Esc>:call NX_ChangeFileFormat()<CR>

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
        if  !empty(glob("~/.vim/plugged/vim-colors-solarized"))
            let cmd_colorscheme = "colorscheme " . g:nx_theme
            execute cmd_colorscheme
            let g:airline_theme = g:nx_theme
            let &background = g:nx_theme_background
        else
            set background=light
        endif
    else
        set background=dark
    endif
endfunction

function! NX_SetTempDirectory()
    " Set swap file directory
    let temp_dir = NX_CreateTempDir("temp")
    let &directory = temp_dir
endfunction

function! NX_EnablePersistentUndo()
    " Persist undo forever
    let undo_dir = NX_CreateTempDir("undo")
    let &undodir = undo_dir
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
    let temp_dir = "/.vim/tmp/" . a:directory
    if has("unix")
        call system("mkdir -p " . temp_dir)
    elseif has("win32")
        let temp_dir = expand("~") . substitute(temp_dir, "/", "\\", "g")
        call system("mkdir " . temp_dir)
    endif
    return temp_dir
endfunction

function! NX_ChangeFileFormat()
    if &fileformats == "unix,dos"
        set fileformats=dos,unix
        set fileformat=dos
        echo "FileFormat set to DOS."
    else
        set fileformats=unix,dos
        set fileformat=unix
        echo "FileFormat set to UNIX."
    endif
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
            let g:nx_szmod = -2
            let g:nx_font_size = "normal"
        elseif g:nx_font_size == "normal"
            let g:nx_szmod = 0
            let g:nx_font_size = "large"
        elseif g:nx_font_size == "large"
            let g:nx_szmod = 2
            let g:nx_font_size = "xlarge"
        elseif g:nx_font_size == "xlarge"
            let g:nx_szmod = 4
            let g:nx_font_size = "small"
        endif

        if has("gui_gtk")
            let &guifont = g:nx_font_unix . " " .
                \ (g:nx_font_size_unix + g:nx_szmod)
        elseif has("gui_win32")
            let &guifont = g:nx_font_dos . ":h" .
                \ (g:nx_font_size_dos + g:nx_szmod)
        elseif has("gui_macvim")
            let &guifont = g:nx_font_mac . ":h" .
                \ (g:nx_font_size_mac + g:nx_szmod)
        endif
    endfunction
endif

call NX_PimpMyVim()

