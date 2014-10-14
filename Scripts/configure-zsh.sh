#!/bin/sh

curl -L http://install.ohmyz.sh | sh
cp ../Configs/.zshrc ~/.zshrc
cp agnoster.zsh-theme ~/.oh-my-zsh/themes/
wget https://gist.github.com/qrush/1595572/raw/417a3fa36e35ca91d6d23ac961071094c26e5fad/Menlo-Powerline.otf
mv Menlo-Powerline.otf ~/usr/share/fonts
fc-cache -vf
