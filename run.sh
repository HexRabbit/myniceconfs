#!/bin/bash

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

# preliminary
if [ $USER == "root" ]; then
  apt-get update
  apt-get install -y build-essential cmake python3-dev jython3-pip vim zsh tmux git curl sed 
else
  sudo apt-get update
  sudo apt-get install -y build-essential cmake python3-dev python3-pip vim zsh tmux git curl sed 
fi

# vim
git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
cp .vimrc $HOME
vim +PluginInstall +qall
cp molokai.vim $HOME/.vim/bundle/molokai/colors/molokai.vim 

# YouCompleteMe (not complete, checkout YCM github for installation details)
python3 $HOME/.vim/bundle/YouCompleteMe/install.py --clang-completer
#`gcc -print-prog-name=cc1` -v
#`gcc -print-prog-name=cc1plus` -v

# oh-my-zsh & completion
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-completions $HOME/.oh-my-zsh/custom/plugins/zsh-completions
sed -i 's/ZSH_THEME=.*/ZSH_THEME="clean"/' $HOME/.zshrc
sed -i 's/plugins=(\(.*\))/plugins=(\1 zsh-completions)/' $HOME/.zshrc
sed -i '/plugins=/a autoload -U compinit && compinit' $HOME/.zshrc
chsh -s $(which zsh)
source $HOME/.zshrc

# tmux & powerline
cp .tmux.conf $HOME
pip3 install --ignore-installed --upgrade --user powerline
echo 'export PATH=$HOME/.local/bin:$PATH' >> $HOME/.zshrc

# gef
git clone https://github.com/hugsy/gef -o $HOME/.gef
cp .gdbinit $HOME
cp gdbscripts $HOME/.gdbscripts -r
