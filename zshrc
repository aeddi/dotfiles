### Shell customization ###

# Set history & misc. parameters
HISTFILE=$HOME/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt extendedglob
autoload -U colors && colors

# Ensure permissions are correct for ZSH completion
autoload -U compaudit && compaudit | xargs chmod g-w
if [[ `uname` == "Darwin" ]]; then
	chown -RL root:staff /usr/local/share/zsh
fi

# Enable ZSH completion
autoload -Uz compinit && compinit

# Get git branch name and dirtiness for right prompt
function git_prompt_info()
{
	ref=$(git symbolic-ref HEAD 2> /dev/null) || return
	if [[ -n $(git status -s 2> /dev/null) ]]; then
		dirty="%{$fg_bold[red]%}"
	else
		dirty="%{$fg_bold[green]%}"
	fi
	echo "$dirty⎇ ${ref#refs/heads/}%{$reset_color%}"
}

# Prompt configuration
PROMPT="%{$fg_bold[blue]%}%* %(!.%{$fg_bold[red]%}.%{$fg_bold[yellow]%})%~ %{$reset_color%}> "
precmd() { RPROMPT="$(git_prompt_info) [%{$fg_no_bold[yellow]%}%?%{$reset_color%}]" } # Re-compute git_prompt_info on each command

# Display CWD as title for xterm* terminals
 case $TERM in
     xterm*)
		 chpwd() {print -Pn "\e]0;%~\a"}
         ;;
 esac


### Zsh plugins ###

source $HOME/.antigen/antigen.zsh

antigen bundle zsh-users/zsh-history-substring-search.git
antigen bundle zsh-users/zsh-completions
antigen bundle unixorn/autoupdate-antigen.zshplugin
antigen-bundle Tarrasch/zsh-bd

antigen apply

# bind UP and DOWN arrow keys to history plugin
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down


### Includes ###

function include()
{
	if [[ -f $1 ]]; then
		source $1
	else
		printf "$1 is missing\n"
	fi
}

include $HOME/.aliases
include $HOME/.functions
include $HOME/.extra

unfunction include
