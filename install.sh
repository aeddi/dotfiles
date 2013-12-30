if [ -f ~/.myvimrc ];
then
   ln -s ~/.dotfiles/config_files/vimrc ~/.myvimrc
   echo "Installing .myvimrc"
else
   ln -s ~/.dotfiles/config_files/vimrc ~/.vimrc
   echo "Installing .vimrc"
fi

echo "Installing Pathogen"
mkdir -p ~/.vim/autoload ~/.vim/bundle; \
curl -Sso ~/.vim/autoload/pathogen.vim \
    https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim
    
cd ~/.vim/bundle
echo "Installing Syntastic"
git clone https://github.com/scrooloose/syntastic.git

echo "Installing NerdTree"
git clone https://github.com/scrooloose/nerdtree.git

echo "Installing Mustang theme"
mkdir -p ~/.vim/colors
ln -s ~/.dotfiles/config_files/mustang.vim ~/.vim/colors

echo "Do you want setting alliases ? [y/n]"
read answer
if [ "$answer" = "y" ]
then
echo "Setting alliases :"
if [ -f ~/.myzshrc ];
then
   echo "For myzshrc"
   echo "alias vimrs='vim -S .mysession.vim'

alias gccW='gcc -Wall -Werror -Wextra'

alias ls='ls -G'
alias ll='ls -lAG'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ln='ln -i'

alias 1.='cd ..'
alias 2.='cd ../..'
alias 3.='cd ../../..'
alias 4.='cd ../../../..'
alias 5.='cd ../../../../..'

alias auteur="echo 'aeddi' > auteur"
alias gitignore="cp ~/.dotfiles/gitignore ./.gitignore"
alias newp="auteur; gitignore; mkdir -p sources; mkdir -p includes; cp -r  ~/.dotfiles/libft  ~/.dotfiles/Makefile ."" >> ~/.myzshrc
fi

if [ -f ~/.zshrc ];
then
   echo "For zshrc"
   echo "alias vimrs='vim -S .mysession.vim'

alias gccW='gcc -Wall -Werror -Wextra'

alias ls='ls -G'
alias ll='ls -lAG'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ln='ln -i'

alias 1.='cd ..'
alias 2.='cd ../..'
alias 3.='cd ../../..'
alias 4.='cd ../../../..'
alias 5.='cd ../../../../..'

alias auteur="echo 'aeddi' > auteur"
alias gitignore="cp ~/.dotfiles/gitignore ./.gitignore"
alias newp="auteur; gitignore; mkdir -p sources; mkdir -p includes; cp -r  ~/.dotfiles/libft  ~/.dotfiles/Makefile ."" >> ~/.zshrc
fi

if [ -f ~/.bashrc ];~/
then
   echo "For bashrc"
   echo "alias vimrs='vim -S .mysession.vim'

alias gccW='gcc -Wall -Werror -Wextra'

alias ls='ls -G'
alias ll='ls -lAG'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ln='ln -i'

alias 1.='cd ..'
alias 2.='cd ../..'
alias 3.='cd ../../..'
alias 4.='cd ../../../..'
alias 5.='cd ../../../../..'

alias auteur="echo 'aeddi' > auteur"
alias gitignore="cp ~/.dotfiles/gitignore ./.gitignore"
alias newp="auteur; gitignore; mkdir -p sources; mkdir -p includes; cp -r  ~/.dotfiles/libft  ~/.dotfiles/Makefile ."" >> ~/.bashrc
fi

if [ -f ~/.shrc ];
then
   echo "For shrc"
   echo "alias vimrs='vim -S .mysession.vim'

alias gccW='gcc -Wall -Werror -Wextra'

alias ls='ls -G'
alias ll='ls -lAG'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ln='ln -i'

alias 1.='cd ..'
alias 2.='cd ../..'
alias 3.='cd ../../..'
alias 4.='cd ../../../..'
alias 5.='cd ../../../../..'

alias auteur="echo 'aeddi' > auteur"
alias gitignore="cp ~/.dotfiles/gitignore ./.gitignore"
alias newp="auteur; gitignore; mkdir -p sources; mkdir -p includes; cp -r  ~/.dotfiles/libft  ~/.dotfiles/Makefile ."" >> ~/.shrc
fi
fi
