#!/bin/bash

SUDO=""

# don't run script in root unless you know what you're doing
if [ $USER == "root" ]; then
  echo "You're running the script with user root,"
  echo "so all the content will be installed for root, continue?"
  select yn in "Yes" "No"; do
      case $yn in
          Yes ) break;;
          No ) exit;;
      esac
  done
fi

if [ $USER != "root" ]; then
  SUDO=sudo
fi

# install dependency
$SUDO apt-get update
$SUDO apt-get install -y build-essential cmake python3-dev python3-pip vim-gtk3 zsh tmux git curl sed

# setup locale
$SUDO locale-gen en_US.UTF-8
$SUDO update-locale LANG=en_US.UTF-8

# vim
git clone --depth=1 https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
cp .vimrc $HOME
sed -i "s/Plugin 'Valloric\/YouCompleteMe'/\"@@@/" $HOME/.vimrc
vim -E -s -u "$HOME/.vimrc" +PluginInstall +qall
sed -i "s/\"@@@/Plugin 'Valloric\/YouCompleteMe'/" $HOME/.vimrc
cp molokai.vim $HOME/.vim/bundle/molokai/colors/molokai.vim 

# YouCompleteMe (not complete, checkout YCM github for installation details)
git clone --depth=1 https://github.com/Valloric/YouCompleteMe $HOME/.vim/bundle/YouCompleteMe
cd $HOME/.vim/bundle/YouCompleteMe
git submodule update --init --recursive
python3 ./install.py --clang-completer
cd -
#`gcc -print-prog-name=cc1` -v
#`gcc -print-prog-name=cc1plus` -v

# oh-my-zsh & completion
git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh $HOME/.oh-my-zsh
cp $HOME/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
sed -i "/export ZSH=/c export ZSH=$HOME/.oh-my-zsh" $HOME/.zshrc
sed -i 's/ZSH_THEME=.*/ZSH_THEME="clean"/' $HOME/.zshrc
sed -i 's/plugins=(\(.*\))/plugins=(\1 zsh-completions)/' $HOME/.zshrc
sed -i '/plugins=/a autoload -U compinit && compinit' $HOME/.zshrc
git clone --depth=1 https://github.com/zsh-users/zsh-completions $HOME/.oh-my-zsh/custom/plugins/zsh-completions
chsh -s $(which zsh)

# tmux & powerline
cp .tmux.conf $HOME
pip3 install --ignore-installed --upgrade --user powerline-status
echo 'export PATH=$HOME/.local/bin:$PATH' >> $HOME/.zshrc

# gef
git clone https://github.com/hugsy/gef $HOME/.gef
cp .gdbinit $HOME
cp gdbscripts $HOME/.gdbscripts -r

exec /bin/zsh
