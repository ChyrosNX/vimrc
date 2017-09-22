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
"     fontSize    = [x|xx|xxx]small | normal | [x|xx|xxx]large
"     background  = light | dark
"     colorscheme = gruvbox | solarized | ...
let g:nxg_font_size   = 'normal'
let g:nxg_background  = 'dark'
let g:nxg_colorscheme = 'gruvbox'
" Font:
let g:nxg_font  = {
    \   'win32' : { 'name': 'Consolas'          , 'size': 11 }
    \   , 'mac' : { 'name': 'Monaco'            , 'size': 12 }
    \   , 'unix': { 'name': 'Monospace Regular' , 'size': 10 }
    \ }


""" Improve GUI experience
set t_vb=           " Disable annoying beeps
set guioptions-=m   " Hide menu bar
set guioptions-=T   " Hide toolbar
set guioptions-=r   " Hide right scroll bar
set guioptions-=L   " hide left scroll bar


""" Mappings
" Ctrl-F2 - Reset Theme
nnoremap <silent> <C-F2> :call NX_ResetTheme(1)<CR>

" F4 - Update Font Size
nnoremap <silent> <F4>   :call NXG_ChangeFontSize(0)<CR>
nnoremap <silent> <S-F4> :call NXG_ChangeFontSize(1)<CR>


""" Init and Clean-up
function! NXG_Init()
    let g:nxg__configFile = '~/.neph_gconfig'
    let g:nxg__fontSizes = [
        \   'xxxsmall'
        \   , 'xxsmall'
        \   , 'xsmall'
        \   , 'small'
        \   , 'normal'
        \   , 'large'
        \   , 'xlarge'
        \   , 'xxlarge'
        \   , 'xxxlarge'
        \ ]
    let g:nxg__userThemes = {}
    if !NX_LoadSettings()
        " No settings file found, apply default themes
        call NX_ResetTheme(0)
    endif
endfunction

function! NXG_CleanUp()
    delfunction NXG_Init
    delfunction NX_LoadSettings
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
            let g:nxg__userThemes['fontSize'] = settings[2]
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
    call add(settings, g:nxg__userThemes['fontSize'])
    call writefile(settings, expand(g:nxg__configFile), 'b')
endfunction

function! NX_ResetTheme(invokedByUser)
    let g:nxg__userThemes = {
        \   'fontSize'      : g:nxg_font_size
        \   , 'background'  : g:nxg_background
        \   , 'colorScheme' : g:nxg_colorscheme
        \ }
    if index(g:nx__colorSchemes, g:nxg__userThemes['colorScheme']) >= 0
        " Apply user color scheme and background
        let g:nx__colorscheme_idx = index(g:nx__colorSchemes
            \ , g:nxg__userThemes['colorScheme'])
        let cmd_colorscheme = 'colorscheme ' . g:nxg__userThemes['colorScheme']
        execute cmd_colorscheme
        let g:airline_theme = g:nxg__userThemes['colorScheme']
        let &background = g:nxg__userThemes['background']
    else
        " User color scheme is not available, apply default
        colorscheme default
        set background=light
    endif
    call NXG_ApplyFontSize()
    if a:invokedByUser
        call NX_SaveSettings()
        redraw
        echo "Theme has been reset to defaults."
    endif
endfunction


""" Neph GVimRC functions
function! NXG_ChangeFontSize(prevStep)
    " Switch font size
    if a:prevStep
        let idx = index(g:nxg__fontSizes, g:nxg__userThemes['fontSize']) - 1
        if idx < 0
            let idx = len(g:nxg__fontSizes) - 1
        endif
    else
        let idx = index(g:nxg__fontSizes, g:nxg__userThemes['fontSize']) + 1
        if idx >= len(g:nxg__fontSizes)
            let idx = 0
        endif
    endif
    let g:nxg__userThemes['fontSize'] = g:nxg__fontSizes[idx]
    call NXG_ApplyFontSize()
    call NX_SaveSettings()
    redraw
    echo 'Font size: '. g:nxg__userThemes['fontSize']
endfunction

function! NXG_ApplyFontSize()
    " Apply font size
    let step = 1
    let sizeModifier = index(g:nxg__fontSizes, g:nxg__userThemes['fontSize'])
        \ * step - (len(g:nxg__fontSizes) / 2)
    if has('win32')
        let &guifont = g:nxg_font['win32']['name'] . ':h' .
            \ (g:nxg_font['win32']['size'] + sizeModifier)
    elseif has('mac') || has('osx')
        let &guifont = g:nxg_font['mac']['name'] . ':h' .
            \ (g:nxg_font['mac']['size'] + sizeModifier)
    elseif has('unix')
        let &guifont = g:nxg_font['unix']['name'] . ' ' .
            \ (g:nxg_font['unix']['size'] + sizeModifier)
    endif
endfunction


""" Init and Clean-up
call NXG_Init()
call NXG_CleanUp()
delfunction NXG_CleanUp

