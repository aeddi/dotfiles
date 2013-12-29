if [ -f ~/.myvimrc ];
then
   ln -s ~/.dotfiles/config_files/vimrc ~/.myvimrc
   echo "Installing .myvimrc"
else
   ln -s ~/.dotfiles/config_files/vimrc ~/.vimrc
   echo "Installing .myvimrc"
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
mkdir -p ~/.vim/color
ln -s ~/.dotfiles/config_files/mustang.vim ~/.myvimrc

echo "Setting alliases :"
if [ -f ~/.myzshrc ];
then
   echo "For myzshrc"
   echo "alias cdc='source ~/.myzshrc ; cd /'
alias fav="sed -i '' '1s?.*?'alias\ cdc=\'source\ \~\/.myzshrc\ \;\ cd\ `pwd`\''?' ~/.myzshrc && source ~/.myzshrc" 

alias vimrs='vim -S .mysession.vim'

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

alias auteur="echo 'aeddi' > auteur"" >> ~/.myzshrc
fi

if [ -f ~/.zshrc ];
then
   echo "For zshrc"
      echo "alias cdc='source ~/.zshrc ; cd /'
alias fav="sed -i '' '1s?.*?'alias\ cdc=\'source\ \~\/.zshrc\ \;\ cd\ `pwd`\''?' ~/.zshrc && source ~/.zshrc" 

alias vimrs='vim -S .mysession.vim'

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

alias auteur="echo 'aeddi' > auteur"" >> ~/.zshrc
fi

if [ -f ~/.bashrc ];~/
then
   echo "For bashrc"
      echo "alias cdc='source ~/.bashrc ; cd /'
alias fav="sed -i '' '1s?.*?'alias\ cdc=\'source\ \~\/.bashrc\ \;\ cd\ `pwd`\''?' ~/.bashrc && source ~/.bashrc" 

alias vimrs='vim -S .mysession.vim'

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

alias auteur="echo 'aeddi' > auteur"" >> ~/.bashrc
fi

if [ -f ~/.shrc ];
then
   echo "For shrc"
   echo "alias cdc='source ~/.shrc ; cd /'
alias fav="sed -i '' '1s?.*?'alias\ cdc=\'source\ \~\/.shrc\ \;\ cd\ `pwd`\''?' ~/.shrc && source ~/.shrc" 

alias vimrs='vim -S .mysession.vim'

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

alias auteur="echo 'aeddi' > auteur"" >> ~/.shrc
fi
