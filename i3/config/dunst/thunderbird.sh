#! /bin/sh
NOTAGS=$(echo $1 | sed -e 's/.*<//g' -e 's/>.*//g')
notify-send -a Thunderbird "$NOTAGS" "$2"
