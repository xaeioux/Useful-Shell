#!/bin/bash
#
#   1 - Validates if the disk is a SSD or HD
#
#   Version:   1.0
#   Revision:  3.0
#   Mantainer: Xaeioux
#   License:   GPL
#===============================================================================

DISK=$(ls /sys/block/ | grep sd* | grep -v sr* > /tmp/disks)
while read LINE; do
	SSD=$(cat /sys/block/$LINE/queue/rotational)
	n=$((n + 1))
	if [ "$SSD" == "0" ]; then
		echo -e $PAPAYA "DISCO $LINE:$GREEN SSD" $RSTCOLOR;
	else
		echo -e $PAPAYA "DISCO $LINE:$RED HDD" $RSTCOLOR;
	fi
done </tmp/disks;
df -h  >/tmp/diskusage
echo -e $PAPAYA "Uso de Disco :" $RSTCOLOR
cat /tmp/diskusage
echo -e $RSTCOLOR
