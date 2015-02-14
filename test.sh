if command -v npm >/dev/null 2>&1
then
	cd $HOME/.vim/bundle/tern_for_vim
	npm install
	cd -
else
	echo "\e[31;1mDon't forget to install Javascript autocompleter\e[00m
	Make sure you have Nodejs and npm installed then launch:
	cd ~/.vim/bundle/tern_for_vim && npm install\n"
fi
