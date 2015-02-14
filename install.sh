#!/bin/zsh

### Define paths ###
SCRIPT_DIR=${0:A:h}
ZSHRC=~/.zshrc
ZSHPG=~/.antigen
VIMRC=~/.vimrc
GITCFG=~/.gitconfig
####################


### Start zsh config ###
echo "\n\e[32;1mZsh configuration start\e[00m"

# Add custom .zshrc
[ -f $ZSHRC ] || touch $ZSHRC
echo "source $SCRIPT_DIR/zshrc" >> $ZSHRC

# Install antigen plugin manager and install plugins
git clone https://github.com/zsh-users/antigen.git $ZSHPG
source $ZSHRC
########################


### Start vim config ###
echo "\n\e[32;1mVim configuration start\e[00m"

# Add custom .zshrc
[ -f $VIMRC ] || touch $VIMRC
echo "source $SCRIPT_DIR/vimrc" >> $VIMRC

# Install vundle plugin manager and install plugins
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# Give complementary instructions for YouCompleteMe
echo "\n\e[31;1mDon't forget to compile YouCompleteMe module\e[00m with ~/.vim/bundle/YouCompleteMe/install.sh
	On Linux usually use: ./install.sh --clang-completer --system-libclang
	For Mac OSX use instead: ./install.sh --clang-completer
	You should have \e[31;1mcmake, python-dev\e[00m and \e[31;1mbuild-essential\e[00m packages installed (names may vary depending of your OS)\n"

# Try install Javascript autocompletion
if command -v npm >/dev/null 2>&1
then
	cd $HOME/.vim/bundle/tern_for_vim
	npm install
	cd -
else
	echo "\n\e[31;1mDon't forget to install Javascript autocompleter\e[00m
	Make sure you have Nodejs and npm installed then launch:
	cd ~/.vim/bundle/tern_for_vim && npm install\n"
fi
########################


### Install better fonts ###
git clone https://github.com/powerline/fonts

# Create fonts dir if host is OSX
if [[ `uname` == 'Darwin' ]]
then
	FONT_DIR="$HOME/Library/Fonts"
	[ -d $FONT_DIR ] || mkdir $FONT_DIR
fi

# Launch install and remove installation files
fonts/install.sh
rm -rf fonts

# Give complementary instructions
echo "\n\e[31;1mChange the font of your terminal\e[00m with a powerline compatible one:
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
	FiraMono"
##############################
