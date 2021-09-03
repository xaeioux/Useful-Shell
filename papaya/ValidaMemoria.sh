#!/bin/bash
#
#  1 - Collects information about RAM usage
#  2 - Shows the percentage of RAM in use
#
#   Version:   2.0
#   Revision:  1.0
#   Mantainer: Xaeioux
#   License:   GPL
#===============================================================================
TOTALMEM=0
FREEMEM=0
i=0

function Percentage(){
	PERCENTAGE1=$(expr 100 \* "$MEGA")
	PERCENTAGE2=$(expr "$PERCENTAGE1" \/ "$TOTALMEM" )
}

egrep 'Mem|Cache' /proc/meminfo | grep -v "Swap" > /tmp/ramusage
MEMORY[0]=$PAPAYA"Memoria Total..............:$RSTCOLOR"
MEMORY[1]=$PAPAYA"Memoria Livre..............:$RSTCOLOR"
MEMORY[2]=$PAPAYA"Memoria Disponivel.........:$RSTCOLOR"
MEMORY[3]=$PAPAYA"Memoria Cache..............:$RSTCOLOR"

while read LINE; do
	RESULT=$(echo "$LINE" | awk '{print $2}')
	MEGA=$(expr $RESULT \/ 1024)

	while [ "$FREEMEM" == 1 ]; do
		FREEMEM="$MEGA"
	done

	while [ "$TOTALMEM" == 0 ]; do
		TOTALMEM="$MEGA"
		FREEMEM=1
	done

	Percentage

	echo -e " "${MEMORY[$i]} "$MEGA Mbs    $PERCENTAGE2%"

	i=$(($i + 1))
done </tmp/ramusage;

USEDMEM=$(expr "$TOTALMEM" - "$FREEMEM")
MEGA="$USEDMEM"

Percentage

if [ "$PERCENTAGE2" -gt 70 ]; then
	echo -e  $PAPAYA "Memoria em uso.............:$RSTCOLOR" $USEDMEM "Mbs   $REDG $PERCENTAGE2% (ALTO USO DE MEMORY)" $RSTCOLOR;
elif [ "$PERCENTAGE2" -lt 40 ]; then
	echo -e  $PAPAYA "Memoria em uso.............:$RSTCOLOR" $USEDMEM "Mbs   $GREENG $PERCENTAGE2%" $RSTCOLOR;
else
	echo -e  $PAPAYA "Memoria em uso.............:$RSTCOLOR" $USEDMEM "Mbs   $YELLOWG $PERCENTAGE2%" $RSTCOLOR;
fi

dmesg | grep "out of memory" | awk {'print $10'} | uniq
echo
