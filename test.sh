#! /bin/bash

REC=1

test()
{
	VAR=$1

	if [ $REC -eq 1 ]; then
		REC=0
		test "Second"
	fi

	echo "$VAR + $1"
}

test "First"
