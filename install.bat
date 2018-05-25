del %USERPROFILE%\.gvimrc
del %USERPROFILE%\.ideavimrc
del %USERPROFILE%\.nephvimrc
del %USERPROFILE%\.vimrc

mklink %USERPROFILE%\.gvimrc    %cd%\.gvimrc
mklink %USERPROFILE%\.ideavimrc %cd%\.ideavimrc
mklink %USERPROFILE%\.nephvimrc %cd%\.nephvimrc
mklink %USERPROFILE%\.vimrc     %cd%\.vimrc

