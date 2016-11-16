#! /bin/bash

test()
{
	if [ -e $1 ]; then
		echo "Exists"
	else
		echo "Not exists"
	fi
}

test zsh
test .
test /etc
test joij
