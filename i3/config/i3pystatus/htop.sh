#! /bin/zsh

if [ -z "$(pidof htop)" ]; then
	gnome-terminal --hide-menubar --role='Htop-win' -x htop
else
	pkill -n htop
fi
