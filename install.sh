#!/bin/zsh

SCRIPT_DIR=$(readlink -f ${0%/*})

VIMRC=~/.vimrc
ZSHRC=~/.zshrc

[ -f $VIMRC ] || touch $VIMRC
echo "source $SCRIPT_DIR/vimrc" >> $VIMRC

[ -f $ZSHRC ] || touch $ZSHRC
echo "source $SCRIPT_DIR/zshrc" >> $ZSHRC

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall 2> /dev/null
