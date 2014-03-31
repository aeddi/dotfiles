echo "\033[31mDo you want setting vimrc ? [y/n]\033[0m"
read answer
if [ "$answer" = "y" ]
then
	if [ -f ~/.myvimrc ];
	then
		echo "Old .myvimrc found"
		mkdir -p ~/.backup_conf_files
		mv ~/.myvimrc  ~/.backup_conf_files/myvimrc_BAK
		echo "\033[32mBackup old .myvimrc\033[0m"
		ln -s ~/.dotfiles/config_files/vimrc ~/.myvimrc
		echo "\033[32mInstalling new .myvimrc\033[0m"
	elif [ -f ~/.vimrc ];
	then
		echo "Old .vimrc found"
		mkdir -p ~/.backup_conf_files
		mv ~/.vimrc  ~/.backup_conf_files/vimrc_BAK
		echo "\033[32mBackup old .vimrc\033[0m"
		ln -s ~/.dotfiles/config_files/vimrc ~/.vimrc
		echo "\033[32mInstalling new .vimrc\033[0m"
	else
		ln -s ~/.dotfiles/config_files/vimrc ~/.vimrc
		echo "\033[32mInstalling .vimrc\033[0m"
	fi
fi

echo "\n\033[31mDo you want install vim plugins and theme ? [y/n]\033[0m"
read answer
if [ "$answer" = "y" ]
then
	echo "\033[32mInstalling Pathogen\033[0m"
	mkdir -p ~/.vim/autoload ~/.vim/bundle; \
	curl -Sso ~/.vim/autoload/pathogen.vim \
    https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim
    
	cd ~/.vim/bundle
	echo "\033[32mInstalling Syntastic\033[0m"
	git clone https://github.com/scrooloose/syntastic.git

	echo "\033[32mInstalling NerdTree\033[0m"
	git clone https://github.com/scrooloose/nerdtree.git

	echo "\033[32mInstalling Easymotion\033[0m"
	git clone https://github.com/Lokaltog/vim-easymotion/ easymotion

	echo "\033[32mInstalling Mustang theme\033[0m"
	mkdir -p ~/.vim/colors
	ln -s ~/.dotfiles/config_files/mustang.vim ~/.vim/colors

	echo "\033[32mInstalling skeletons\033[0m"
	ln -s ~/.dotfiles/config_files/skeleton ~/.vim/skeleton
fi

echo "\n\033[31mDo you want setting shell alliases and functions ? [y/n]\033[0m"
read answer
if [ "$answer" = "y" ]
then
	echo "\033[32mSetting alliases \c\033[0m"
	if [ -f ~/.myzshrc ];
	then
	   	echo "\033[32mfor myzshrc\033[0m"
		mkdir -p ~/.backup_conf_files
		mv ~/.myzshrc ~/.backup_conf_files/myzshrc_BAK
		echo "\033[32mBackup old .myzshrc\033[0m"
		ln -s ~/.dotfiles/conf_files/zshrc ~/.myzshrc
		echo "\033[32mInstalling .myzshrc\n\033[0m"
	fi

	if [ -f ~/.zshrc ];
	then
	   	echo "\033[32mfor zshrc\033[0m"
		mkdir -p ~/.backup_conf_files
		mv ~/.zshrc ~/.backup_conf_files/zshrc_BAK
		echo "\033[32mBackup old .zshrc\033[0m"
		ln -s ~/.dotfiles/conf_files/zshrc ~/.zshrc
		echo "\033[32mInstalling .zshrc\n\033[0m"
	fi
fi
