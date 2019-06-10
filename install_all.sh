#!/bin/bash

SUDO=""
VundleDir="$HOME/.vim/bundle/Vundle.vim"
YCMDir="$HOME/.vim/bundle/YouCompleteMe"
OhMyZshDir="$HOME/.oh-my-zsh"
ZshRc="$HOME/.zshrc"
VimRc="$HOME/.vimrc"

# don't run script in root unless you know what you're doing
if [ "$USER" == "root" ]; then
  echo "You're running the script with user root,"
  echo "so all the content will be installed for root, continue?"
  select yn in "Yes" "No"; do
      case "$yn" in
          Yes ) break;;
          No ) exit;;
      esac
  done
fi

if [ "$USER" != "root" ]; then
  SUDO=sudo
fi

# install dependency
"$SUDO" apt-get update
"$SUDO" apt-get install -y build-essential cmake python3-dev python3-pip vim-gtk3 zsh tmux git curl sed

# setup locale
"$SUDO" locale-gen en_US.UTF-8
"$SUDO" update-locale LANG=en_US.UTF-8

# vim
git clone --depth=1 https://github.com/VundleVim/Vundle.vim.git "$VundleDir"
cp .vimrc "$VimRc"
sed -i "s/Plugin 'Valloric\\/YouCompleteMe'/\"@@@/" "$VimRc"
vim -E -s -u "$VimRc" +PluginInstall +qall
sed -i "s/\"@@@/Plugin 'Valloric\\/YouCompleteMe'/" "$VimRc"
cp molokai.vim "$HOME/.vim/bundle/molokai/colors/molokai.vim"

# YouCompleteMe (not complete, checkout YCM github for installation details)
git clone --depth=1 https://github.com/Valloric/YouCompleteMe "$YCMDir"
git -C "$YCMDir" submodule update --init --recursive
python3 "$YCMDir/install.py" --clang-completer
#`gcc -print-prog-name=cc1` -v
#`gcc -print-prog-name=cc1plus` -v

# oh-my-zsh & completion
git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh "$HOME/.oh-my-zsh"
cp "$OhMyZshDir/templates/zshrc.zsh-template" "$ZshRc"
sed -i "/export ZSH=/c export ZSH=$OhMyZshDir" "$ZshRc"
sed -i 's/ZSH_THEME=.*/ZSH_THEME="clean"/' "$ZshRc"
sed -i 's/plugins=(\(.*\))/plugins=(\1 zsh-completions)/' "$ZshRc"
sed -i '/plugins=/a autoload -U compinit && compinit' "$ZshRc"
git clone --depth=1 https://github.com/zsh-users/zsh-completions "$OhMyZshDir/custom/plugins/zsh-completions"
chsh -s "$(command -v zsh)"

# tmux & powerline
cp .tmux.conf "$HOME"
pip3 install --ignore-installed --upgrade --user powerline-status
echo 'export PATH=$HOME/.local/bin:$PATH' >> "$ZshRc"

# gef
git clone https://github.com/hugsy/gef "$HOME/.gef"
cp .gdbinit "$HOME"
cp gdbscripts "$HOME/.gdbscripts" -r

exec /bin/zsh
