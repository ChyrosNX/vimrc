"""
"
" VimRC Settings
"
" Author  : ChyrosNX
" Version : 0.0.1-Alpha
"
" Desc    : ChyrosNX's settings for VIM.
"
" README (for first time users)
"
" - This .vimrc uses vim-plug. To auto-install vim-plug:
"
"       1) download 'plug.vim' from https://github.com/junegunn/vim-plug
"       2) put downloaded file to your ~/.vim/ directory
"       3) start/restart your Vim using this .vimrc file
"
" TODO:
"   1) Delete trailing whitespaces on save
"   2) Ctrl+F2 resets to default color scheme
"
"""


source ~/.nephvimrc " Load Neph Library

set nocompatible    " Use VIM to its full potential
set encoding=utf-8
filetype plugin on  " Enable plugin for specific file types


""" User settings
"   editorWidth = text-width + line-num-width + sign-width + rt-margin-width
let s:editorWidth       = (80+4+2+2)*2+1  
let s:showEditorGuides  = 1
let s:tempDir           = '~/.vim/temp/temp'
let s:undoDir           = '~/.vim/temp/undo'
let s:pluginDir         = '~/.vim/plugged'

let s:hasVimPlug = !empty(glob(g:nx__autoloadDir . 'plug.vim'))
let s:hasCtagsBin = !empty(glob(s:pluginDir . '/ctags/ctags.exe'))

set visualbell t_vb=                " Disable beeps
let &columns = s:editorWidth        " Set window width by column size
set lines=40                        " Set window height by lines
set listchars=eol:┐,tab:»\ ,trail:· " Editor guides symbols


""" Initialize Neph Library
call NX_Init(s:tempDir, s:undoDir, s:pluginDir, s:showEditorGuides)


""" Plugins
let s:enabledPlugins = []
" themes
call add(s:enabledPlugins, 'morhetz/gruvbox')
call add(s:enabledPlugins, 'chriskempson/base16-vim')
call add(s:enabledPlugins, 'altercation/vim-colors-solarized')
call add(s:enabledPlugins, 'sjl/badwolf')
" status and tab line
call add(s:enabledPlugins, 'vim-airline/vim-airline')
" vim-airline theme
call add(s:enabledPlugins, 'vim-airline/vim-airline-themes')
" file system explorer
call add(s:enabledPlugins, 'scrooloose/nerdtree')
" fuzzy file search, mru, etc
call add(s:enabledPlugins, 'kien/ctrlp.vim')
" git integration
call add(s:enabledPlugins, 'tpope/vim-fugitive')
" git diff signs
call add(s:enabledPlugins, 'airblade/vim-gitgutter')
" vcs diff signs
call add(s:enabledPlugins, 'mhinz/vim-signify')
" surround text w/ braces, etc
call add(s:enabledPlugins, 'tpope/vim-surround')
" comment functions
call add(s:enabledPlugins, 'scrooloose/nerdcommenter')
" syntax-checking
call add(s:enabledPlugins, 'scrooloose/syntastic')
" class outline viewer
call add(s:enabledPlugins, 'majutsushi/tagbar')
" python plug-in
call add(s:enabledPlugins, 'klen/python-mode')

if s:hasVimPlug
    call plug#begin(s:pluginDir)
    for plugin in s:enabledPlugins
        Plug plugin
    endfor
    call plug#end()
endif


""" Plugin Settings
if NX_HasPlugin(s:enabledPlugins, 'vim-airline')
    " Show window tabs on top
    let g:airline#extensions#tabline#enabled = 1
endif
if NX_HasPlugin(s:enabledPlugins, 'nerdtree')
    " Show hidden files in NERDTree
    let NERDTreeShowHidden = 1
endif
if NX_HasPlugin(s:enabledPlugins, 'ctrlp.vim')
    " Show hidden files in Ctrlp
    let g:ctrlp_show_hidden = 1
endif
if NX_HasPlugin(s:enabledPlugins, 'tagbar')
    if has('unix')
        " NOTE: install ctags using OS software package
    elseif has('win32') && s:hasCtagsBin
        " NOTE: download binary from: http://ctags.sourceforge.net/
        " and put the contents at ~/.vim/plugged/ctags
        let g:tagbar_ctags_bin = '~/.vim/plugged/ctags/ctags.exe'
    endif
endif
if NX_HasPlugin(s:enabledPlugins, 'python-mode')
    let g:pymode_rope = 0               " Disabled due to slow-caching issue
    let g:pymode_python = 'python3'     " python2 | python3
endif
if NX_HasPlugin(s:enabledPlugins, 'syntastic')
    """ Syntastic...
    " Last given warning message
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*
    let g:syntastic_always_populate_loc_list = 1    " Fill loc-list with errors
    let g:syntastic_auto_loc_list = 1               " Open loc-list on errors
    let g:syntastic_check_on_open = 0               " Run syntax checks on open
    let g:syntastic_check_on_wq = 0                 " Skips check on close
endif
if NX_HasPlugin(s:enabledPlugins, 'nerdcommenter')
    " Space after comment delimiter
    let g:NERDSpaceDelims = 1
    " Align when inserting a comment
    let g:NERDDefaultAlign = 'left'
    let g:NERDCustomDelimiters = {
        \     'c'     : { 'left': '/**','right': '*/' }
        \     , 'java': { 'left': '/**','right': '*/' }
        \ }
    " Include empty lines when commenting
    let g:NERDCommentEmptyLines = 1
    " Uncommenting removes trailing spaces
    let g:NERDTrimTrailingWhitespace = 1
endif


""" VIM Settings
set autoread                    " Auto reload file changes, if any
set backspace=indent,eol,start  " Make <BS> more useful
set clipboard=unnamed           " Use gui-clipboard instead
set history=1000                " Max command-line history to persist

" Tabstops and Indentions
set tabstop=4                   " Number of spaces for <Tab>
set shiftwidth=4                " Number of spaces for << and >>
set expandtab                   " Use spaces instead of a tab
set autoindent                  " Copy indent to the next line
set smartindent                 " Language-specific auto-indentation

"set autochdir                  " Auto change dir based on the open file
set number                      " Show line numbers
syntax on                       " Enable syntax highlighting
set nowrap                      " Don't wrap text by default
set scrolloff=1                 " Use scroll offset of 1

set ignorecase                  " Ignore-case searching
set hlsearch                    " Enable search highlighting
set incsearch                   " Enable incremental search


""" Platform-specific Settings
if has('unix')
    set shell=bash\ -i          " Source .bashrc environment
endif


""" Mappings
let mapleader = '\'

" python-mode Mappings
let g:pymode_rope_goto_definition_bind = '<A-g>'  " Alt+G -> Goto-definition

" Unmap navigation keys
noremap <Up>      :echo 'One does not simply 'go up' with Arrow Keys.'<CR>
noremap <Down>    :echo 'One does not simply 'go down' with Arrow Keys.'<CR>
noremap <Left>    :echo 'One does not simply 'go left' with Arrow Keys.'<CR>
noremap <Right>   :echo 'One does not simply 'go right' with Arrow Keys.'<CR>
noremap <Space>   <nop>
noremap <C-Space> <nop>
noremap <BS>      <nop>
noremap <S-BS>    <nop>
noremap <C-BS>    <nop>

" Map Ctrl+H/J/K/L for navigating buffers used by some plugins
nnoremap <C-j> <Up>
nnoremap <C-k> <Down>
nnoremap <C-h> <Left>
nnoremap <C-l> <Right>

" Map Space to different functionalities
nnoremap <silent> <S-Space> :call NX_SpaceFunction()<CR>

" Map Ctrl+ArrowKeys for changing window size
nnoremap <silent> <C-Up>      :res +5<CR>
nnoremap <silent> <C-Down>    :res -5<CR>
nnoremap <silent> <C-Left>    :vert res -5<CR>
nnoremap <silent> <C-Right>   :vert res +5<CR>

nnoremap <silent> <C-S-Up>    :res +1<CR>
nnoremap <silent> <C-S-Down>  :res -1<CR>
nnoremap <silent> <C-S-Left>  :vert res -1<CR>
nnoremap <silent> <C-S-Right> :vert res +1<CR>

" Alt+1 Custom NERDTree Toggle
nnoremap <silent> <A-1>      :call NX_NERDTreeToggle()<CR>
inoremap <silent> <A-1> <Esc>:call NX_NERDTreeToggle()<CR>

" Alt+2 TagbarToggle
nnoremap <silent> <A-2>      :TagbarToggle<CR>
inoremap <silent> <A-2> <Esc>:TagbarToggle<CR>

" F2 - Change Theme Settings
nnoremap <silent> <F2>   :call NX_ChangeColorScheme(0)<CR>
nnoremap <silent> <S-F2> :call NX_ChangeColorScheme(1)<CR>
nnoremap <silent> <F3>   :call NX_ToggleBackground()<CR>
nnoremap <silent> <S-F3> :call NX_ToggleBackground()<CR>

" F5 Show/hide editor guides
nnoremap <silent> <F5>      :call NX_ShowEditorGuides(0)<CR>
inoremap <silent> <F5> <Esc>:call NX_ShowEditorGuides(0)<CR>

" F6 Change FileFormat DOS <-> UNIX
nnoremap <silent> <F6>      :call NX_ChangeFileFormat()<CR>
inoremap <silent> <F6> <Esc>:call NX_ChangeFileFormat()<CR>

" Alt+[X|Z] Next/Prev Tab
nnoremap <silent> <A-x>      :tabn<CR>
inoremap <silent> <A-x> <Esc>:tabn<CR>
nnoremap <silent> <A-z>      :tabp<CR>
inoremap <silent> <A-z> <Esc>:tabp<CR>

" Ctrl+N New Tab
nnoremap <silent> <C-n>      :tabnew<CR>
inoremap <silent> <C-n> <Esc>:tabnew<CR>

" Alt+C - Close Current Tab
nnoremap <silent> <A-c>      :q<CR>
inoremap <silent> <A-c> <Esc>:q<CR>

" Alt+Q - Close Current Tab Without Saving!
nnoremap <silent> <A-q>      :q!<CR>
inoremap <silent> <A-q> <Esc>:q!<CR>

" Shift+Alt+C - Close Other Tabs
nnoremap <silent> <A-C>      :tabonly<CR>
inoremap <silent> <A-C> <Esc>:tabonly<CR>

" Alt+[J|K] - Move lines up/down
nnoremap <silent> <A-j>      :m . +1<CR>
inoremap <silent> <A-j> <Esc>:m . +1<CR>
nnoremap <silent> <A-k>      :m . -2<CR>
inoremap <silent> <A-k> <Esc>:m . -2<CR>

" Ctrl+S - Save File
nnoremap <silent> <C-s>      :w<CR>
inoremap <silent> <C-s> <Esc>:w<CR>

" Leader+r - Find and replace all (whole word)
nnoremap <Leader>r yiw:%s/\<*\>//g<Left><Left>

" Leader+R - Find and replace all
nnoremap <Leader>R yiw:%s/*//g<Left><Left>

" Leader+c - Count all from buffer with (Requires value in register *)
nnoremap <Leader>c yiw:%s/*//gn<CR>


""" Post-init
call NX_LoadSettings()
call NX_CleanUp()
delfunction NX_CleanUp

