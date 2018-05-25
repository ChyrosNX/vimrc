@echo off

echo * Delete existing vim/tmux config files...
del %USERPROFILE%\.gvimrc 2>nul
del %USERPROFILE%\.ideavimrc 2>nul
del %USERPROFILE%\.nephvimrc 2>nul
del %USERPROFILE%\.tmux.conf 2>nul
del %USERPROFILE%\.vimrc 2>nul

echo.
echo * Creating symlinks for vim/tmux config files...
mklink %USERPROFILE%\.gvimrc    %cd%\.gvimrc 2>nul
mklink %USERPROFILE%\.ideavimrc %cd%\.ideavimrc 2>nul
mklink %USERPROFILE%\.nephvimrc %cd%\.nephvimrc 2>nul
mklink %USERPROFILE%\.tmux.conf %cd%\.tmux.conf 2>nul
mklink %USERPROFILE%\.vimrc     %cd%\.vimrc 2>nul

echo.
echo To complete installation, do the ff.:
echo -------------------------------------
echo.
echo     1) Download 'plug.vim' from 'https://github.com/junegunn/vim-plug'
echo        and place it to %USERPROFILE%\.vim folder.
echo.
echo     2) Run 'vim' to finish installation.
echo.

