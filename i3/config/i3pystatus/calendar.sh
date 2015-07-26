#! /bin/zsh

if [ -z "$(pidof gsimplecal)" ]; then
	gsimplecal&
else
	pkill -n gsimplecal
fi
