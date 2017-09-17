"""
"
" GVimRC Settings File
"
" Author  : ChyrosNX
" Version : 0.0.1-Alpha
"
" Desc    : GUI-related vim settings.
"
"""


set t_vb=  " Disable beeps
set guioptions-=m   " Hide menu bar
set guioptions-=T   " Hide toolbar
set guioptions-=r   " Hide right-side scroll bar
set guioptions-=L   " hide left-side scroll bar

""" gVim Font & Theme Settings
" User Theme Settings
let g:nx_font_size = "normal"       " small | normal | large | xlarge
let g:nx_theme_background = "dark"  " light | dark
let g:nx_theme = "gruvbox"
" Font Name
let g:nx_font_unix = "Monospace Regular"
let g:nx_font_dos = "Consolas"
let g:nx_font_mac = "Monaco"
" Base Font Size
let g:nx_font_size_unix = 10
let g:nx_font_size_dos = 11
let g:nx_font_size_mac = 12


""" Mappings

" F4 - Update Font Size
nnoremap <F4> :call NX_UpdateFontSize()<CR>


""" Custom functions
function! NX_ApplyTheme()
    " Apply color schemes
    if index(g:nx__colorschemes, g:nx_theme) >= 0
        let g:nx__colorscheme_idx = index(g:nx__colorschemes, g:nx_theme)
        let cmd_colorscheme = "colorscheme " . g:nx_theme
        execute cmd_colorscheme
        let g:airline_theme = g:nx_theme
        let &background = g:nx_theme_background
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

    if has("gtk")
        let &guifont = g:nx_font_unix . " " .
            \ (g:nx_font_size_unix + g:nx_szmod)
    elseif has("win32")
        let &guifont = g:nx_font_dos . ":h" .
            \ (g:nx_font_size_dos + g:nx_szmod)
    elseif has("macvim")
        let &guifont = g:nx_font_mac . ":h" .
            \ (g:nx_font_size_mac + g:nx_szmod)
    endif
endfunction


""" Init and Clean-up
call NX_UpdateFontSize()    " Update font size
call NX_ApplyTheme()        " Apply color schemes
delfunction NX_ApplyTheme

