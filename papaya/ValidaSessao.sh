#!/bin/bash
#
#   1 - Validates who is connected via SSH
#   2 - Show how many users are connected
#
#   Version:   2.0
#   Revision:  3.0
#   Mantainer: Xaeioux
#   License:   GPL
#===============================================================================

MYUSER=$(whoami)
SESSION=$(tty | egrep pts\/[0-9] | awk -F/ '{print $4}')
n=1

w | grep "$MYUSER" >/tmp/who;
while read LINE; do
	USERVAL=$(echo "$LINE" | awk '{print $2}' | awk -F 'pts/' '{print $2}')
	n=$((n + 1))
	if [ "$SESSION" != "$USERVAL" ]; then
		echo -e $RED "Outra Sessao  $n: $LINE" $RSTCOLOR;
	else
		echo -e $GREEN "Sua Sessao    $n: $LINE" $RSTCOLOR;
	fi
done </tmp/who;
echo -e $RSTCOLOR
