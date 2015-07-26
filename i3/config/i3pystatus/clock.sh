#! /bin/zsh

if [ -z "$(pidof gnome-clocks)" ]; then
	exec gnome-clocks&
fi
