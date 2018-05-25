#!/bin/bash

echo "* Delete existing vim/tmux config files..."
rm ~/.gvimrc 2> /dev/null
rm ~/.ideavimrc 2> /dev/null
rm ~/.nephvimrc 2> /dev/null
rm ~/.tmux.conf 2> /dev/null
rm ~/.vimrc 2> /dev/null

echo -e "\n* Creating symlinks for vim/tmux config files..."
ln -s $PWD/.gvimrc    ~/.gvimrc
ln -s $PWD/.ideavimrc ~/.ideavimrc
ln -s $PWD/.nephvimrc ~/.nephvimrc
ln -s $PWD/.tmux.conf ~/.tmux.conf
ln -s $PWD/.vimrc     ~/.vimrc

echo -e "\nTo complete installation, do the ff.:"
echo -e "-------------------------------------"
echo -e "\n\t1) Run 'vim' to finish installation.\n"

