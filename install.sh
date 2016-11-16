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
		printf -- "${OPS}- Full version${RESET} is good for decent CPU, not for RPi or small VM\n"
		printf -- "${OPS}- Medium version${RESET} comes without completion feature: Reactivity++\n"
		printf -- "${OPS}- Light version${RESET} removes slow plugins (completion, syntax check. & colorscheme):\n"
		printf -- "\tStartup speed++ (4x faster) & Reactivity+++\n\n"

		OPTIONS=( 'Full install' 'Medium (no completion)' 'Light (no slow plugin)' )
		PS3=$'\n\e[1;39mYour choice: \e[0m'

		select OPT in "${OPTIONS[@]}"; do
			read SEL <<< "$REPLY"
			case $SEL in
				1) SELECTED=("${SELECTED[@]/vim/vim-full}"); break ;;
				2) SELECTED=("${SELECTED[@]/vim/vim-medium}"); break ;;
				3) SELECTED=("${SELECTED[@]/vim/vim-light}"); break ;;
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
	SOURCE_REL=$(sed "s:$HOME:~:g" <<< $SOURCE)
	TARGET_REL=$(sed "s:$HOME:~:g" <<< $TARGET)
	
	if [ "$SOURCE" -ef "$TARGET" ]; then
		printf -- "${OPS}Link [$SOURCE_REL -> $TARGET_REL] already set up: ${SUCCESS}success${RESET}\n"
		return 0
	fi

	if [ -e "$TARGET" ] || [ -L "$TARGET" ]; then
		printf -- "${WARNING}Warning: $TARGET_REL already exist!${RESET}\n"
		printf -- "${OPS}Backup it, Overwrite it or Abort? [B|o|a]${RESET} "
		read INPUT
		if [[ $INPUT == 'a' || $INPUT == 'A' ]]; then
			return 2
		elif [[ $INPUT == 'o' || $INPUT == 'O' ]]; then
			(rm -rf $TARGET															\
			&& printf -- "${OPS}Erase $TARGET_REL: ${SUCCESS}success${RESET}\n")	\
			|| { printf -- "${OPS}Erase $TARGET_REL: ${ERROR}error${RESET}\n" >&2; return 1; }
		else
			(mkdir -p $BACKUP_DIR && mv $TARGET $BACKUP_DIR							\
			&& printf -- "${OPS}Backup $TARGET_REL: ${SUCCESS}success${RESET}\n")	\
			|| { printf -- "${OPS}Backup $TARGET_REL: ${ERROR}error${RESET}\n" >&2; return 1; }
		fi
	fi

	(ln -s $SOURCE $TARGET																				\
	&& printf -- "${OPS}Symlink creation [$SOURCE_REL -> $TARGET_REL]: ${SUCCESS}success${RESET}\n")	\
	|| { printf -- "${OPS}Symlink creation [$SOURCE_REL -> $TARGET_REL]: ${ERROR}error${RESET}\n" >&2; return 1; }
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
	cd $HOME
	printf -- "${DELIM}\n\n"
}


install_packages()
{
	local PACKAGES=("${@}")

	# Check if brew is installed
	if [[ `uname` == 'Darwin' ]] && ! which brew &> /dev/null; then
		printf -- "${WARNING}You may need to install brew on your Mac to install dependencies.${RESET}\n"
		printf -- "${OPS}Install it now ? [Y|n]${RESET} "
		read INPUT
		if [[ $INPUT != 'n' && $INPUT != 'N' ]]; then
			printf "${OPS}Installing brew...${RESET}\n" 
			printf -- "${DELIM4}\n"
			/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" 2>&1	\
			| (format_subscript; printf -- "${DELIM4}\n\n");														\
			ERR=${PIPESTATUS[0]}; [[ $ERR -ne 0 ]] && return 1
			cd $HOME
		else
			return 1
		fi
	fi

	ERR=0
	printf -- "${OPS}Installing depencies...${RESET}\n"
	printf -- "${DELIM4}\n"
	{ {
		if which brew &> /dev/null; then
			[[ "${PACKAGES[@]}" =~ "ycm" ]] && PACKAGES=(${PACKAGES[@]/ycm} 'cmake' 'go' 'rust' 'node' 'mono')
			[[ $UPDATED -eq 0 ]] && (brew update && UPDATED=1 || ERR=1)
			brew install ${PACKAGES[*]} 2>&1 || ERR=1
		elif which pacman &> /dev/null; then
			[[ "${PACKAGES[@]}" =~ "ycm" ]] && PACKAGES=(${PACKAGES[@]/ycm} 'base-devel' 'cmake' 'python2' 'python3' 'go' 'rust' 'cargo' 'nodejs' 'npm' 'mono')
			[[ $UPDATED -eq 0 ]] && (sudo pacman -Syu --noconfirm && UPDATED=1 || ERR=1)
			sudo pacman -S --noconfirm ${PACKAGES[*]} || ERR=1
		elif which apt-get &> /dev/null; then
			if [[ "${PACKAGES[@]}" =~ "ycm" ]]; then
				PACKAGES=(${PACKAGES[@]/ycm} 'build-essential' 'automake' 'cmake' 'python-dev' 'python3-dev' 'golang' 'node' 'npm' 'mono-complete')
				install_packages 'curl' && curl -sf -L https://static.rust-lang.org/rustup.sh | sh || ERR=1
			fi
			[[ $UPDATED -eq 0 ]] && (sudo apt-get update -y && UPDATED=1 || ERR=1)
			sudo apt-get install -y ${PACKAGES[*]} || ERR=1
			[[ "${PACKAGES[@]}" =~ "node" ]] && sudo ln -s /usr/bin/nodejs /usr/bin/node || ERR=1
		elif which yum &> /dev/null; then
			if [[ "${PACKAGES[@]}" =~ "ycm" ]]; then
			 	PACKAGES=(${PACKAGES[@]/ycm} 'gcc' 'gcc-c++' 'automake' 'cmake' 'python-devel' 'go' 'rust' 'cargo' 'node' 'npm' 'mono-complete')
				[[ -n "$(grep -i 'centos\|red[[:space:]]hat' /etc/redhat-release)" ]] && install_packages 'epel-release'
				if [[ -z "$(yum repolist | grep 'download.mono-project.com')" ]]; then
					install_packages 'yum-utils'
					sudo rpm --import "http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF"
					sudo yum-config-manager --add-repo http://download.mono-project.com/repo/centos/
				fi
				sudo yum update -y && UPDATED=1 || ERR=1
			fi
			[[ $UPDATED -eq 0 ]] && (sudo yum update -y && UPDATED=1 || ERR=1)
			sudo yum install -y ${PACKAGES[*]} || ERR=1
		else
			[[ "${PACKAGES[@]}" =~ "ycm" ]] && PACKAGES=(${PACKAGES[@]/ycm} 'gcc' 'g++' 'automake' 'cmake' 'python2-dev' 'python3-dev' 'go' 'rust' 'cargo' 'node' 'npm' 'mono-complete')
			printf -- "${WARNING}Package manager not detected. You may need to install this packages manually:${RESET}\n${PACKAGES[*]}\n"
			ERR=1
		fi
	} 2>&1; } | (format_subscript; printf -- "${DELIM4}\n\n")

	return $ERR
}

format_subscript()
{
	awk -v WIDTH=75 '
	{
		gsub(/\t/, "   ");
		while (length>WIDTH) {
			print "   | " substr($0,1,WIDTH);
			$0=substr($0,WIDTH+1);
		}
		print "   | " $0;
		fflush();
	}'
}

vim_config()
{
	DEP=('vim' 'git')
	[[ "${SELECTED[@]}" =~ "vim-full" ]] && DEP+=('ycm')
	install_packages "${DEP[@]}"															\
	|| { printf -- "${OPS}Continue installation without depencies or Abort? [C|a]${RESET} "	\
		&& read INPUT; [[ $INPUT == 'a' || $INPUT == 'A' ]] && return 2; }
	cd $HOME

	[[ "${SELECTED[@]}" =~ "vim-full" ]] && { create_symlink vim/vimrc $HOME/.vimrc || return; }
	[[ "${SELECTED[@]}" =~ "vim-medium" ]] && { create_symlink vim/vimrc_medium $HOME/.vimrc || return; }
	[[ "${SELECTED[@]}" =~ "vim-light" ]] && { create_symlink vim/vimrc_light $HOME/.vimrc || return; }

	if [[ -d $HOME/.vim/bundle/Vundle.vim ]]; then
		printf "${OPS}Vundle already installed: ${SUCCESS}success${RESET}\n"
	else
		printf "${OPS}Installing vundle:${RESET} "
		(git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim &> /dev/null	\
		&& printf -- "${SUCCESS}success${RESET}\n")															\
		|| { printf -- "${ERROR}error${RESET}\n" >&2; return 1; }
	fi

	vim +PluginInstall +qall &> /dev/null &
	printf "${OPS}Installing plugins with vundle:${RESET} [|] "
	SPIN='|/-\'
	sleep 0.5
	while [[ 42 ]]; do
		LOOP="$(ps aux | grep '[v]im +PluginInstall +qall')"

		TMP=${SPIN#?}
		printf "\b\b\b\b[%c] " "$SPIN"
		SPIN=$TMP${SPIN%"$TMP"}

		CUR_PLUGIN=$(ps aux | grep "git clone .* $HOME/.vim/bundle/[[:alnum:]]" | awk -v OFS='\n' '{$1=$1}1' | grep "^$HOME/\.vim/bundle/[[:alnum:]]\+$")
		[[ -n "$CUR_PLUGIN" ]] && CUR_PLUGIN="$(basename $CUR_PLUGIN) "
		if [[ -z "$LOOP" || -n "$CUR_PLUGIN" && "$CUR_PLUGIN" != "$LAST_PLUGIN" ]]; then
			SIZE=$(( ${#LAST_PLUGIN} + 4 ))
			SPACE=`printf '%*s' "$SIZE"`
			ERASE=`printf "$SPACE" | tr ' ' '\b'`
			if [[ -z "$LOOP" ]]; then
				printf -- "${ERASE}${SPACE}${ERASE}${SUCCESS}success${RESET}\n"
				break
			fi
			printf -- "${ERASE}${SPACE}${ERASE}${CUR_PLUGIN}[%c] " "$SPIN"
			LAST_PLUGIN=$CUR_PLUGIN
		fi

		sleep 0.2
	done

	if [[ "${SELECTED[@]}" =~ "vim-full" ]]; then
		printf "${OPS}Installing YouCompleteMe server...${RESET}\n"
		printf -- "${DELIM4}\n"
		$HOME/.vim/bundle/YouCompleteMe/install.py --all 2>&1	\
		| (format_subscript; printf -- "${DELIM4}\n\n");		\
		ERR=${PIPESTATUS[0]}; [[ $ERR -ne 0 ]] && return 1
		cd $HOME
	fi

	if [ ! -f $HOME/.vimrc_local ]; then
		printf "${OPS}Adding .vimrc_local config file:${RESET} " 
		(echo '" Put your local vim settings here' > $HOME/.vimrc_local	\
		&& printf -- "${SUCCESS}success${RESET}\n")						\
		|| { printf -- "${ERROR}error${RESET}\n" >&2; return 1; }
	fi

	return 0
}


zsh_config()
{
	DEP=('zsh')
	[[ "${SELECTED[@]}" =~ "zsh-full" ]] && DEP+=('git')
	install_packages "${DEP[@]}"															\
	|| { printf -- "${OPS}Continue installation without depencies or Abort? [C|a]${RESET} "	\
		&& read INPUT; [[ $INPUT == 'a' || $INPUT == 'A' ]] && return 2; }
	cd $HOME

	[[ "${SELECTED[@]}" =~ "zsh-full" ]] && { create_symlink zsh/zshrc $HOME/.zshrc || return; }
	[[ "${SELECTED[@]}" =~ "zsh-light" ]] && { reate_symlink zsh/zshrc_light $HOME/.zshrc || return; }
	create_symlink zsh/aliases $HOME/.aliases || return
	create_symlink zsh/functions $HOME/.functions

	if [ ! -f $HOME/.zshrc_local ]; then
		printf "${OPS}Adding .zshrc_local config file:${RESET} " 
		(echo '# Put your local zsh settings here' > $HOME/.zshrc_local	\
		&& printf -- "${SUCCESS}success${RESET}\n")						\
		|| { printf -- "${ERROR}error${RESET}\n" >&2; return 1; }
	fi

	if [[ "${SELECTED[@]}" =~ "zsh-full" ]]; then
		if [ -d $HOME/.antigen ]; then
			printf "${OPS}Antigen already installed: ${SUCCESS}success${RESET}\n" 
		else
			printf "${OPS}Installing antigen to $HOME/.antigen:${RESET} " 
			(git clone https://github.com/zsh-users/antigen.git .antigen &> /dev/null	\
			&& printf -- "${SUCCESS}success${RESET}\n")									\
			|| { printf -- "${ERROR}error${RESET}\n" >&2; return 1; }
		fi

		printf "${OPS}Installing antigen plugins...${RESET}\n" 
		printf -- "${DELIM4}\n"
		zsh -c "source $HOME/.zshrc" 2>&1					\
		| (format_subscript; printf -- "${DELIM4}\n\n");	\
		ERR=${PIPESTATUS[0]}; [[ $ERR -ne 0 ]] && return 1
	fi

	printf -- "${OPS}Do you want to set zsh as your default shell? [Y|n]${RESET} "
	read INPUT
	if [[ $INPUT != 'n' && $INPUT != 'N' ]]; then
		(chsh -s /bin/zsh > /dev/null															\
		&& printf -- "${OPS}Setting up zsh as your default shell: ${SUCCESS}success${RESET}\n")	\
		|| { printf -- "${OPS}Setting up zsh as your default shell: ${ERROR}error${RESET}\n" >&2; return 1; }
	fi

	return 0
}


git_config()
{
	DEP=('git')
	echo "${DEP[@]}"

	create_symlink git/gitconfig $HOME/.gitconfig || return
	create_symlink git/gitignore $HOME/.gitignore

	if [ ! -f $HOME/.gitconfig_local ]; then
		printf "${OPS}Adding .gitconfig_local config file:${RESET} " 
		(echo '# Put your local git settings here' > $HOME/.gitconfig_local	\
		&& printf -- "${SUCCESS}success${RESET}\n")							\
		|| { printf -- "${ERROR}error${RESET}\n" >&2; return 1; }
	fi
	return 0
}


i3_config()
{
	printf -- "${WARNING}Abort: i3 config installation not implemented yet!${RESET}\n"
	return 2
}


tern_config()
{
	create_symlink tern-project $HOME/.tern-project || return
	return 0
}


iterm2_config()
{
	[[ `uname` != 'Darwin' ]] && { printf -- "${WARNING}Abort: iTerm2 only exist on macOS!${RESET}\n"; return 2; }
	if ! defaults read -app iTerm &> /dev/null; then
		printf -- "${WARNING}Warning: it seems iTerm2 is not installed${RESET}\n"
		printf -- "${OPS}Do you want to try an automatic install? [Y|n]${RESET} "
		read INPUT
		if [[ $INPUT != 'n' && $INPUT != 'N' ]]; then
			install_packages 'Caskroom/cask/iterm2'													\
			|| { printf -- "${OPS}Continue installation without depencies or Abort? [C|a]${RESET} "	\
			&& read INPUT; [[ $INPUT == 'a' || $INPUT == 'A' ]] && return 2; }
			cd $HOME
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

	install_packages 'git'																	\
	|| { printf -- "${OPS}Continue installation without depencies or Abort? [C|a]${RESET} "	\
		&& read INPUT; [[ $INPUT == 'a' || $INPUT == 'A' ]] && return 2; }
	cd $HOME

	printf "${OPS}Downloading fonts from Github...${RESET}\n" 
	{ git clone -q https://github.com/powerline/fonts /tmp/fonts && cd /tmp/fonts	\
	&& printf "${OPS}Installing fonts...${RESET}\n" && ./install.sh					\
	&& rm -rf /tmp/fonts && return 0; }												\
	|| rm -rf /tmp/fonts && return 1
}


# Useful path vars
BACKUP_DIR=$HOME/.config_backup
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
LOGFILE=$DOTFILES_DIR/install_logs

# Update boolean
UPDATED=0

# Format sudo prompt for subscript
export SUDO_PROMPT="   | %u's password: "

# Text formating vars
TITLE='\e[1;33m'
OPS='\e[1;39m'
SUCCESS='\e[1;32m'
WARNING=$TITLE
ERROR='\e[1;31m'
RESET='\e[0m'
DELIM='--------------------------------------------------------------------------------'
DELIM2='  ---------  '
DELIM3='=========================================='
DELIM4='   +--------------------------------------'

((printf "${DELIM3}\n$(date)\n${DELIM3}\n\n" >> $LOGFILE

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

printf -- "${OPS}Installation logs are available in:${RESET} $LOGFILE\n"
