#!/usr/bin/env bash

selection_menu()
{
	# Configuration parts selection
	printf -- "${DELIM}\n"
	printf -- "${TITLE}Which configuration parts do you want to install?${RESET}\n\n"

	OPTIONS=( 'vim' 'zsh' 'git' 'i3' 'tern' 'iterm2' 'powerline-fonts' )
	PS3=$'\n\e[1;39mYour choices: \e[0m'

	select OPT in "${OPTIONS[@]}"; do
		IFS=', ' read -ra CHOICES <<< "$REPLY"
		for CHOICE in "${CHOICES[@]}"; do
			(( CHOICE >= 1 && CHOICE <= ${#OPTIONS[@]} )) || { printf "${ERROR}Invalid choice:${RESET} $CHOICE. Try again.\n" >&2; continue 2; }
			[[ "${SELECTED[@]}" =~ "${OPTIONS[CHOICE-1]}" ]] || SELECTED+=(${OPTIONS[CHOICE-1]})
		done
		break
	done

	printf -- "${SUCCESS}Selected:${RESET} $(sed 's/ /, /g' <<< ${SELECTED[*]})\n"


	# Vim version selection
	if [[ "${SELECTED[@]}" =~ "vim" ]]; then
		printf -- "\n${DELIM2}\n\n"
		printf -- "${TITLE}Which version of the vim configuration do you want to install?${RESET}\n\n"

		OPTIONS=( 'Full install' 'Light (no completion)' 'Lightest (no plugin)' )
		PS3=$'\n\e[1;39mYour choice: \e[0m'

		select OPT in "${OPTIONS[@]}"; do
			read SEL <<< "$REPLY"
			case $SEL in
				1) SELECTED=("${SELECTED[@]/vim/vim-full}"); break ;;
				2) SELECTED=("${SELECTED[@]/vim/vim-light}"); break ;;
				3) SELECTED=("${SELECTED[@]/vim/vim-lightest}"); break ;;
				*) printf "${ERROR}Invalid choice:${RESET} $SEL. Try again.\n" >&2;;
			esac
		done

		printf -- "${SUCCESS}Selected:${RESET} $OPT\n"
	fi


	# Zsh version selection
	if [[ "${SELECTED[@]}" =~ "zsh" ]]; then
		printf -- "\n${DELIM2}\n\n"
		printf -- "${TITLE}Which version of the zsh configuration do you want to install?${RESET}\n\n"

		OPTIONS=( 'Full install' 'Light (no plugin)' )
		PS3=$'\n\e[1;39mYour choice: \e[0m'

		select OPT in "${OPTIONS[@]}"; do
			read SEL <<< "$REPLY"
			case $SEL in
				1) SELECTED=("${SELECTED[@]/zsh/zsh-full}"); break ;;
				2) SELECTED=("${SELECTED[@]/zsh/zsh-light}"); break ;;
				*) printf "${ERROR}Invalid choice:${RESET} $SEL. Try again.\n" >&2;;
			esac
		done

		printf -- "${SUCCESS}Selected:${RESET} $OPT\n"
	fi
	printf -- "${DELIM}\n\n"
}


create_symlink()
{
	SOURCE=$DOTFILES_DIR/$1
	TARGET=$2
	
	if [ "$SOURCE" -ef "$TARGET" ]; then
		printf -- "${OPS}Link [$SOURCE -> $TARGET] already set up: ${SUCCESS}success${RESET}\n"
		return 0
	fi

	if [ -f "$TARGET" ]; then
		printf -- "${WARNING}Warning: $TARGET already exist!${RESET}\n"
		printf -- "${OPS}Backup it, Overwrite it or Abort? [B|o|a]${RESET} "
		read INPUT
		if [[ $INPUT == 'a' || $INPUT == 'A' ]]; then
			return 2
		elif [[ $INPUT == 'o' || $INPUT == 'O' ]]; then
			(rm -rf $TARGET												\
			&& printf -- "Erase $TARGET: ${SUCCESS}success${RESET}\n")	\
			|| { printf -- "Erase $TARGET: ${ERROR}error${RESET}\n" >&2; return 1; }
		else
			(mkdir -p $BACKUP_DIR && mv $TARGET $BACKUP_DIR				\
			&& printf -- "Backup $TARGET: ${SUCCESS}success${RESET}\n")	\
			|| { printf -- "Backup $TARGET: ${ERROR}error${RESET}\n" >&2; return 1; }
		fi
	fi

	(ln -s $SOURCE $TARGET																\
	&& printf -- "Symlink creation [$SOURCE -> $TARGET]: ${SUCCESS}success${RESET}\n")	\
	|| { printf -- "Symlink creation [$SOURCE -> $TARGET]: ${ERROR}error${RESET}\n" >&2; return 1; }
	return 0
}

launch()
{
	printf -- "${DELIM}\n"
	printf -- "${TITLE}Configuration of $1 - part $(( ++COUNT ))/${#SELECTED[@]}${RESET}\n\n"
	$2; RET=$?
	if [[ $RET -eq 0 ]]; then
		printf "\n${SUCCESS}$1 configuration succeeded${RESET}\n"
	elif [[ $RET -eq 1 ]]; then
		printf "\n${ERROR}$1 configuration failed${RESET}\n" >&2
	else
		printf "\n${WARNING}$1 configuration aborted${RESET}\n" >&2
	fi
	printf -- "${DELIM}\n\n"
}


install_packages()
{
	UPDATED=0

	# Check if brew is installed
	if [[ `uname` == 'Darwin' ]] && ! which brew &> /dev/null; then
		printf -- "${WARNING}You may need to install brew on your Mac to install dependencies.${RESET}\n"
		printf -- "${OPS}Install it now ? [Y|n]${RESET} "
		read INPUT
		if [[ $INPUT != 'n' && $INPUT != 'N' ]]; then
			/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
		fi
	fi

	if which brew; then
		[[ $UPDATED ]] || (brew update && UPDATE=1) || return 1
		brew install $PACKAGES || return 1
	elif which pacman; then
		[[ $UPDATED ]] || (sudo pacman -Syu --noconfirm && UPDATE=1) || return 1
		sudo pacman -S --noconfirm $PACKAGES || return 1
	elif which apt-get; then
		[[ $UPDATED ]] || (sudo apt-get update -y && UPDATE=1) || return 1
		sudo apt-get install -y $PACKAGES || return 1
	elif which yum; then
		[[ $UPDATED ]] || (sudo yum update -y && UPDATE=1) || return 1
		sudo yum install -y $PACKAGES || return 1
	else
		printf -- "${WARNING}Package manager not detected. You may need to install this packages manually:${RESET}\n$PACKAGES\n"
		return 1
	fi

	return 0
}


vim_config()
{
	printf -- "${WARNING}Abort: vim config installation not implemented yet!${RESET}\n"
	return 2
}


zsh_config()
{
	printf -- "${WARNING}Abort: zsh config installation not implemented yet!${RESET}\n"
	return 2
}


git_config()
{
	printf -- "${WARNING}Abort: git config installation not implemented yet!${RESET}\n"
	return 2
}


i3_config()
{
	printf -- "${WARNING}Abort: i3 config installation not implemented yet!${RESET}\n"
	return 2
}


tern_config()
{
	printf -- "${WARNING}Abort: tern config installation not implemented yet!${RESET}\n"
	return 2
}


iterm2_config()
{
	[[ `uname` != 'Darwin' ]] && { printf -- "${WARNING}Abort: iTerm2 only exist on macOS!${RESET}\n"; return 2; }
	if ! defaults read -app iTerm &> /dev/null; then
		printf -- "${WARNING}Warning: it seems iTerm2 is not installed${RESET}\n"
		printf -- "${OPS}Do you want to try an automatic install? [Y|n]${RESET} "
		read INPUT
		if [[ $INPUT != 'n' && $INPUT != 'N' ]]; then
			if install_packages 'Caskroom/cask/iterm2'; then return $?; fi
		else
			return 2
		fi
	fi

	if [ -f $HOME/Library/Preferences/com.googlecode.iterm2.plist ]; then
		printf -- "${OPS}Do you want to backup the old iTerm2 config file? [Y|n]${RESET} "
		read INPUT
		if [[ $INPUT != 'n' && $INPUT != 'N' ]]; then
			(mkdir -p $BACKUP_DIR													\
			&& cp $HOME/Library/Preferences/com.googlecode.iterm2.plist $BACKUP_DIR	\
			&& printf -- "Backup iTerm2 config file: ${SUCCESS}success${RESET}\n")	\
			|| { printf -- "Backup iTerm2 config file: ${ERROR}error${RESET}\n" >&2; return 1; }
		fi
	fi

	printf "${OPS}Setting up new config file:${RESET} " 
	{ defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true							\
	&& defaults write com.googlecode.iterm2 NoSyncNeverRemindPrefsChangesLostForFile -bool true			\
	&& defaults write com.googlecode.iterm2 NoSyncNeverRemindPrefsChangesLostForFile_selection -int 0	\
	&& defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$DOTFILES_DIR/iterm2"			\
	&& printf -- "${SUCCESS}success${RESET}\n" && return 0; }											\
	|| printf -- "${ERROR}error${RESET}\n" >&2; return 1;
}


fonts_config()
{
	if [[ `uname` == 'Darwin' ]]; then
		mkdir -p "$HOME/Library/Fonts"
	fi

	printf "${OPS}Downloading fonts from Github...${RESET}\n" 
	{ curl -L --progress-bar https://github.com/powerline/fonts/archive/master.tar.gz > /tmp/fonts.tar.gz	\
	&& printf "${OPS}Extracting files form archive...${RESET}\n" && cd /tmp && tar xf fonts.tar.gz			\
	&& printf "${OPS}Installing fonts...${RESET}\n" && cd fonts-master && ./install.sh						\
	&& rm -rf /tmp/fonts{.tar.gz,-master} && return 0; }													\
	|| rm -rf /tmp/fonts{.tar.gz,-master} && return 1
}


# Useful path vars
BACKUP_DIR=$HOME/.config_backup
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
LOGFILE=$DOTFILES_DIR/install_logs

# Text formating vars
TITLE='\e[1;33m'
OPS='\e[1;39m'
SUCCESS='\e[1;32m'
WARNING=$TITLE
ERROR='\e[1;31m'
RESET='\e[0m'
DELIM='--------------------------------------------------------------------------------'
DELIM2='  ---------  '

((printf "$(date)\n${DELIM}\n\n" >> $LOGFILE

# Select config parts and launch install
selection_menu

FAILED=()
ABORTED=()
SUCCEEDED=()
for PART in "${SELECTED[@]}"; do
	case $PART in
		vim*) launch $PART vim_config;;
		zsh*) launch $PART zsh_config;;
		git) launch $PART git_config;;
		i3) launch $PART i3_config;;
		tern) launch $PART tern_config;;
		iterm2) launch $PART iterm2_config;;
		power*) launch $PART fonts_config;;
	esac
	[[ $RET -eq 1 ]] && FAILED+=($PART)
	[[ $RET -eq 2 ]] && ABORTED+=($PART)
	[[ $RET -eq 0 ]] && SUCCEEDED+=($PART)
done

# Print report
printf -- "${ERROR}Installation failed:${RESET} "
printf -- "${OPS}${#FAILED[@]}/${#SELECTED[@]} $([[ ${FAILED[@]} ]] && echo "[$(sed 's/ /, /g' <<< ${FAILED[*]})]" )${RESET}\n"

printf -- "${WARNING}Installation aborted:${RESET} "
printf -- "${OPS}${#ABORTED[@]}/${#SELECTED[@]} $([[ ${ABORTED[@]} ]] && echo "[$(sed 's/ /, /g' <<< ${ABORTED[*]})]" )${RESET}\n"

printf -- "${SUCCESS}Installation succeeded:${RESET} "
printf -- "${OPS}${#SUCCEEDED[@]}/${#SELECTED[@]} $([[ ${SUCCEEDED[@]} ]] && echo "[$(sed 's/ /, /g' <<< ${SUCCEEDED[*]})]" )${RESET}\n\n"
) 2>&1) | tee >(sed $'s,\x1b\\[[0-9;]*[a-zA-Z],,g' >> $LOGFILE)

printf -- "${OPS}Install logs are available in:${RESET} $LOGFILE\n"
