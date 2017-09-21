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


""" User Settings
" Theme:
"     fontSize   = small | normal | large | xlarge
"     background = light | dark
let g:nxg_theme = {
    \   'fontSize'      : 'normal'
    \   , 'background'  : 'dark'
    \   , 'colorscheme' : 'gruvbox'
    \ }
" Font
let g:nxg_font = {
    \   'win32' : { 'name': 'Consolas'         , 'size': 11 }
    \   , 'mac' : { 'name': 'Monaco'           , 'size': 12 }
    \   , 'unix': { 'name': 'Monospace Regular', 'size': 10 }
    \ }

let g:nxg__fontSizes = ['small', 'normal', 'large', 'xlarge']

""" Improve GUI experience
set t_vb=           " Disable annoying beeps
set guioptions-=m   " Hide menu bar
set guioptions-=T   " Hide toolbar
set guioptions-=r   " Hide right scroll bar
set guioptions-=L   " hide left scroll bar


""" Mappings
" F4 - Update Font Size
nnoremap <silent> <F4>   :call NXG_ChangeFontSize(0)<CR>
nnoremap <silent> <S-F4> :call NXG_ChangeFontSize(1)<CR>


""" Init and Clean-up
function! NXG_Init()
    let g:nxg__configFile = '~/.neph_gconfig'
    call NXG_SetupThemes()
endfunction

function! NXG_CleanUp()
    delfunction NX_LoadSettings
    delfunction NXG_SetupThemes
endfunction


""" Override NephLibrary save/load settings functions
function! NX_LoadSettings()
    " Load GUI config file if it exists
    if !empty(glob(g:nxg__configFile))
        let settings = readfile(glob(g:nxg__configFile))
        if len(settings) > 0
            call NX_ApplyColorScheme(settings[0])
        endif
        if len(settings) > 1
            call NX_ApplyBackground(settings[1])
        endif
        if len(settings) > 2
            let g:nxg_theme['fontSize'] = settings[2]
            call NXG_ApplyFontSize()
        endif
        return 1
    endif
    return 0
endfunction

function! NX_SaveSettings()
    let settings = []
    call add(settings, g:colors_name)
    call add(settings, &background)
    call add(settings, g:nxg_theme['fontSize'])
    call writefile(settings, expand(g:nxg__configFile), 'b')
endfunction


""" Neph GVimRC functions
function! NXG_SetupThemes()
    if !NX_LoadSettings()
        " No settings file found, apply default themes
        if index(g:nx__colorschemes, g:nxg_theme['colorscheme']) >= 0
            " Apply user colorscheme and background
            let g:nx__colorscheme_idx = index(g:nx__colorschemes
                \ , g:nxg_theme['colorscheme'])
            let cmd_colorscheme = 'colorscheme ' . g:nxg_theme['colorscheme']
            execute cmd_colorscheme
            let g:airline_theme = g:nxg_theme['colorscheme']
            let &background = g:nxg_theme['background']
        else
            " User colorscheme is not available, apply default
            colorscheme default
            set background=light
        endif
        call NXG_ApplyFontSize()
    endif
endfunction

function! NXG_ChangeFontSize(prevStep)
    " Switch font size
    if a:prevStep
        let idx = index(g:nxg__fontSizes, g:nxg_theme['fontSize']) - 1
        if idx < 0
            let idx = len(g:nxg__fontSizes) - 1
        endif
    else
        let idx = index(g:nxg__fontSizes, g:nxg_theme['fontSize']) + 1
        if idx >= len(g:nxg__fontSizes)
            let idx = 0
        endif
    endif
    let g:nxg_theme['fontSize'] = g:nxg__fontSizes[idx]
    call NXG_ApplyFontSize()
    call NX_SaveSettings()
    redraw
    echo 'Font size: '. g:nxg_theme['fontSize']
endfunction

function! NXG_ApplyFontSize()
    " Apply font size
    let step = 2
    let size_mod = index(g:nxg__fontSizes, g:nxg_theme['fontSize'])
        \ * step - step
    if has('win32')
        let &guifont = g:nxg_font['win32']['name'] . ':h' .
            \ (g:nxg_font['win32']['size'] + size_mod)
    elseif has('mac') || has('osx')
        let &guifont = g:nxg_font['mac']['name'] . ':h' .
            \ (g:nxg_font['mac']['size'] + size_mod)
    elseif has('unix')
        let &guifont = g:nxg_font['unix']['name'] . ' ' .
            \ (g:nxg_font['unix']['size'] + size_mod)
    endif
endfunction


""" Init and Clean-up
call NXG_Init()
call NXG_CleanUp()
delfunction NXG_CleanUp

