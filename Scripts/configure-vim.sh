#!/bin/sh

rm -rf ~/.vim/bundle/vundle
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
cp ../Configs/.vimrc ~/.vimrc
vim +PluginInstall +qall
