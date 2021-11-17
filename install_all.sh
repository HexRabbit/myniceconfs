#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
export TZ=Asia/Taipei

# install dependency
sudo apt-get update
sudo apt-get install -y build-essential cmake python3-dev python3-pip vim-gtk3 zsh tmux git curl sed wget gdb

# configure system locale
sudo locale-gen en_US.UTF-8
sudo localectl set-locale LANG=en_US.UTF-8

# vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cp .vimrc $HOME
vim -E -s -u "$HOME/.vimrc" +PlugInstall +qall
cp molokai.vim $HOME/.vim/plugged/molokai/colors/molokai.vim 
cp coc-setting.json "$HOME/.vim/coc-settings.json"

# oh-my-zsh & completion
git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh $HOME/.oh-my-zsh
cp $HOME/.zshrc $HOME/.zshrc.bak
cp $HOME/.oh-my-zsh/templates/zshrc.zsh-template $HOME/.zshrc
sed -i "/export ZSH=/c export ZSH=$HOME/.oh-my-zsh" $HOME/.zshrc
sed -i 's/ZSH_THEME=.*/ZSH_THEME="clean"/' $HOME/.zshrc
sed -i 's/plugins=(\(.*\))/plugins=(\1 zsh-completions)/' $HOME/.zshrc
sed -i '/plugins=/a autoload -U compinit && compinit' $HOME/.zshrc
git clone --depth=1 https://github.com/zsh-users/zsh-completions $HOME/.oh-my-zsh/custom/plugins/zsh-completions
chsh -s $(which zsh)

# tmux (force to use 256 color)
cp .tmux.conf $HOME
echo 'alias tmux="tmux -2"' >> $HOME/.zshrc

# gef
wget -O $HOME/.gdbinit-gef.py -q http://gef.blah.cat/py
cp -r gdbscripts $HOME/.gdbscripts
cp .gdbinit $HOME

exec /bin/zsh
