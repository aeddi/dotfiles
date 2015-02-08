#!/bin/zsh

SCRIPT_DIR=${0:A:h}
echo "$SCRIPT_DIR"

ZSHRC=~/.zshrc
ZSHPG=~/.antigen
VIMRC=~/.vimrc
GITCFG=~/.gitconfig

echo "\e[32;1mZsh configuration start\e[00m"

[ -f $ZSHRC ] || touch $ZSHRC
echo "source $SCRIPT_DIR/zshrc" >> $ZSHRC

git clone https://github.com/zsh-users/antigen.git $ZSHPG
source $ZSHRC


echo "\e[32;1mVim configuration start\e[00m"

[ -f $VIMRC ] || touch $VIMRC
echo "source $SCRIPT_DIR/vimrc" >> $VIMRC

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

git clone https://github.com/powerline/fonts fonts
if [[ `uname` == 'Darwin' ]]
then
	FONT_DIR="$HOME/Library/Fonts"
	[ -d $FONT_DIR ] || mkdir $FONT_DIR
fi
fonts/install.sh
echo "
\e[31;1mDon't forget to compile YouCompleteMe module\e[00m with ~/.vim/bundle/YouCompleteMe/install.sh
	Usually for Linux use: ./install.sh --clang-completer --system-libclang
	Mac OSX use instead: ./install.sh --clang-completer

\e[31;1mChange the font of your terminal\e[00m with a powerline compatible one:
	Anonymous Pro
	DejaVu Sans Mono
	Droid Sans Mono
	Inconsolata
	Inconsolata-dz  <-- \e[04mMy favorite one !\e[00m
	Inconsolata-g
	Liberation Mono
	Meslo
	Source Code Pro
	Terminus
	Ubuntu Mono
	Monofur
	FiraMono\n"
rm -rf fonts
