#!/bin/bash

# preliminary
sudo apt-get install -y build-essential cmake python3-dev vim zsh tmux git curl

# vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp .vimrc ~/
vim +PluginInstall
cp molokai.vim ~/.vim/bundle/molokai/colors/molokai.vim 

# YouCompleteMe
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer
#`gcc -print-prog-name=cc1` -v
#`gcc -print-prog-name=cc1plus` -v

# oh-my-zsh & completion
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
sed -i 's/ZSH_THEME=.*/ZSH_THEME="clean"/' ~/.zshrc
sed -i 's/plugins=(\(.*\))/plugins=(\1 zsh-completions)' ~/.zshrc
sed -i '/plugins=/a autoload -U compinit && compinit' ~/.zshrc
chsh -s $(which zsh)

# tmux & powerline
cp .tmux.conf ~/
pip3 install --ignore-installed --upgrade --user powerline
echo 'export PATH=/home/$USER/.local/bin:$PATH' >> ~/.zshrc

# gef
git clone https://github.com/hugsy/gef -o ~/.gef
cp .gdbinit ~/
cp .gdbscripts ~/ -r
