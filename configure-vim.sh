rm -rf ~/.vim/bundle/vundle
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
cp .vimrc ~/.vimrc
vim +PluginInstall +qall
