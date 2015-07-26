#! /bin/zsh

if [ -z "$(pidof pacmixer)" ]; then
	gnome-terminal --hide-menubar --role='Pacmixer-win' -x pacmixer
else
	pkill -n pacmixer
fi
