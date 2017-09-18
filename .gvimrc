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


set t_vb=           " Disable beeps
set guioptions-=m   " Hide menu bar
set guioptions-=T   " Hide toolbar
set guioptions-=r   " Hide right-side scroll bar
set guioptions-=L   " hide left-side scroll bar


" User Theme Settings
let g:nxg__font_size = "normal"         " small | normal | large | xlarge
let g:nxg__theme_background = "dark"    " light | dark
let g:nxg__theme = "gruvbox"
" Font Name
let g:nxg__font_dos = "Consolas"
let g:nxg__font_mac = "Monaco"
let g:nxg__font_unix = "Monospace Regular"
" Base Font Size
let g:nxg__font_size_dos = 11
let g:nxg__font_size_mac = 12
let g:nxg__font_size_unix = 10


""" Mappings

" F4 - Update Font Size
nnoremap <silent> <F4> :call NXG_ChangeFontSize()<CR>:call NX_SaveSettings()<CR>:call NXG_FontInfo()<CR>


""" Init and Clean-up
function! NXG_Init()
    let g:nxg__configFile = "~/.neph_gconfig"
    call NXG_ApplyTheme()
endfunction

function! NXG_CleanUp()
    delfunction NX_LoadSettings
    delfunction NXG_ApplyTheme
endfunction


""" Override Neph Library functions
function! NX_LoadSettings()
    " Load GUI config file if it exists
    if !empty(glob(g:nxg__configFile))
        let settings = readfile(glob(g:nxg__configFile))
        if len(settings) > 3
            let g:nxg__font_size = settings[2]
            let g:nxg__szmod = settings[3]
            call NXG_ApplyFontSize()
        endif
        if len(settings) > 0
            call NX_ApplyColorScheme(settings[0])
        endif
        if len(settings) > 1
            call NX_ApplyBackground(settings[1])
        endif
        return 1
    endif
    return 0
endfunction

function! NX_SaveSettings()
    let settings = []
    call add(settings, g:colors_name)
    call add(settings, &background)
    call add(settings, g:nxg__font_size)
    call add(settings, g:nxg__szmod)
    call writefile(settings, expand(g:nxg__configFile), "b")
endfunction


""" Neph GVimRC functions
function! NXG_ApplyTheme()
    if !NX_LoadSettings()
        " Apply color schemes
        if index(g:nx__colorschemes, g:nxg__theme) >= 0
            let g:nx__colorscheme_idx = index(g:nx__colorschemes
                        \ , g:nxg__theme)
            let cmd_colorscheme = "colorscheme " . g:nxg__theme
            execute cmd_colorscheme
            let g:airline_theme = g:nxg__theme
            let &background = g:nxg__theme_background
        else
            set background=light
        endif
        call NXG_ApplyFontSize()
    endif
endfunction

function! NXG_ChangeFontSize()
    " Switch font size
    if g:nxg__font_size == "small"
        let g:nxg__font_size = "normal"
    elseif g:nxg__font_size == "normal"
        let g:nxg__font_size = "large"
    elseif g:nxg__font_size == "large"
        let g:nxg__font_size = "xlarge"
    elseif g:nxg__font_size == "xlarge"
        let g:nxg__font_size = "small"
    endif
    call NXG_ApplyFontSize()
endfunction

function! NXG_ApplyFontSize()
    " Apply font size
    if g:nxg__font_size == "small"
        let g:nxg__szmod = -2
    elseif g:nxg__font_size == "normal"
        let g:nxg__szmod = 0
    elseif g:nxg__font_size == "large"
        let g:nxg__szmod = 2
    elseif g:nxg__font_size == "xlarge"
        let g:nxg__szmod = 4
    endif
    if has("win32")
        let &guifont = g:nxg__font_dos . ":h" .
            \ (g:nxg__font_size_dos + g:nxg__szmod)
    elseif has("macvim")
        let &guifont = g:nxg__font_mac . ":h" .
            \ (g:nxg__font_size_mac + g:nxg__szmod)
    elseif has("unix")
        let &guifont = g:nxg__font_unix . " " .
            \ (g:nxg__font_size_unix + g:nxg__szmod)
    endif
endfunction

function! NXG_FontInfo()
    echo "Font size: ". g:nxg__font_size
endfunction

""" Init and Clean-up
call NXG_Init()        " Apply color schemes
call NXG_CleanUp()
delfunction NXG_CleanUp

