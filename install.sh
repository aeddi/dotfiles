#!/bin/zsh

SCRIPT_DIR=${0:A:h}
echo "$SCRIPT_DIR"

VIMRC=~/.vimrc
ZSHRC=~/.zshrc
GITCFG=~/.gitconfig

[ -f $VIMRC ] || touch $VIMRC
echo "source $SCRIPT_DIR/vimrc" >> $VIMRC

[ -f $ZSHRC ] || touch $ZSHRC
echo "source $SCRIPT_DIR/zshrc" >> $ZSHRC

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

[ -f $GITCFG ] || touch $GITCFG
echo "[color]
	interactive = always
[color \"interactive\"]
	error = red bold" >> $GITCFG
