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

git clone https://github.com/powerline/fontsfonts
fonts/install.sh
echo "Don't forget to change the police of your term with a powerline compatible one:
    Anonymous Pro
    DejaVu Sans Mono
    Droid Sans Mono
    Inconsolata
    Inconsolata-dz
    Inconsolata-g
    Liberation Mono
    Meslo
    Source Code Pro
    Terminus
    Ubuntu Mono
    Monofur
    FiraMono"
