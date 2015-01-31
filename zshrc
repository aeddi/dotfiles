export MARKPATH=$HOME/.marks
export CONFPATH=${0:A:h}

### Alias part ###

alias wcc='gcc -Wall -Werror -Wextra'
alias w++='g++ -Wall -Werror -Wextra'

alias ls='ls -G'
alias ll='ls -lAGh'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ln='ln -i'

alias 1.='cd ..'
alias 2.='cd ../..'
alias 3.='cd ../../..'
alias 4.='cd ../../../..'
alias 5.='cd ../../../../..'

alias vimrs='vim -S .mysession.vim'
alias auteur="echo 'aeddi' > auteur"
alias gitignore="cp $CONFPATH/project_template/gitignore ./.gitignore"


### Projects management functions ###

function newp()
{
	auteur
	gitignore
	mkdir -p sources
	cp $CONFPATH/project_template/syntastic_c_config sources/.syntastic_c_config
	mkdir -p includes
	cp -r $CONFPATH/project_template/libft  $CONFPATH/project_template/Makefile .
}

function gitdup()
{ 
	echo "\033[31mAre you sure want duplicate this git repo ? [y/n]\033[0m"
	read answer
	if [ "$answer" = "y" ]
	then
		REP=$(basename $(pwd))
		REPLOW=$(echo "$REP" | tr '[A-Z]'  '[a-z]')
		curl --user Plastic-1 https://api.bitbucket.org/1.0/repositories/ --data name=$REP
		git remote add bitbucket https://Plastic-1@bitbucket.org/Plastic-1/$REPLOW.git
		git add -A
		git commit -m "First dup"
		git push bitbucket master
		echo "[remote \"all\"]" >> .git/config
		grep url .git/config >> .git/config
	fi
}

function gitf()
{
	if [ "$#" -ne 1 ]
	then
		echo "Usage: gitf \"Commit message\"";
	else
		git add -A
		git commit -m $1
		git push
	fi
}


### 42 related functions ###

function fstud()
{ 
	if [[ -z $@ ]]
	then
		echo "Usage: fstud <students>";
	else
		crawler="https://dashboard.42.fr/crawler/pull"
		for user in $@
		do
			printf "\033[31m\033[47m $@ \033[0m\n"
			PHONE=$(ldapsearch -Q uid="$@" | grep -e "^mobile" | sed 's/mobile: /# /g')
			if [ -n "$PHONE" ] 
			then
				printf "\033[32m$PHONE\n\033[0m"
			else
				printf "\033[31m# No phone number\n\033[0m"
			fi
			crawl=$(curl $crawler/$user/ -s | tr ',\|}' '\n' | tr '\"' '.')
			poste=$(echo $crawl | grep last_host | cut -d'.' -f4)
			active=$(echo $crawl | grep last_activity | cut -d'.' -f3 | cut -d' ' -f2)
			if [ $active ]
			then
				printf "\033[32m# $poste\n\033[0m"
			else
				printf "\033[31m# Not at school\n\033[0m"
			fi
			printf "\n"
		done
	fi
}


### Quick navigation function ###

function jump { 
    cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}

function mark { 
    mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}

function unmark { 
    rm -i "$MARKPATH/$1"
}

function marks {
    \ls -l "$MARKPATH" | tail -n +2 | sed 's/  / /g' | cut -d' ' -f9- | awk -F ' -> ' '{printf "%-10s -> %s\n", $1, $2}'
}

function _completemarks {
  reply=($(ls $MARKPATH))
}

compctl -K _completemarks jump
compctl -K _completemarks unmark


### Shell customization ###

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt extendedglob

autoload -Uz compinit
autoload -U colors && colors
compinit

PROMPT="%{$fg_bold[blue]%}%* %{$fg_bold[yellow]%}%~ %{$reset_color%}> "
RPROMPT="[%{$fg_no_bold[yellow]%}%?%{$reset_color%}]"

case $TERM in
    xterm*)
        precmd () {print -Pn "\e]0;%~\a"}
        ;;
esac

###########################
