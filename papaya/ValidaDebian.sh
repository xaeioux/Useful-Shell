#!/bin/bash
#
#   1 - Operational System name
#   2 - Operational system version
#   3 - Kernel Version
#
#   Version:   2.0
#   Revision:  4.0
#   Mantainer: Xaeioux
#   License:   GPL
#===============================================================================

cat /etc/os-release | grep 'NAME\|VERSION' | grep -v 'VERSION_ID' | grep -v 'PRETTY_NAME' >/tmp/osrelease
NAME=$(cat /tmp/osrelease | grep -v "VERSION" | cut -f2 -d\" | awk '{print $1}')
VERSION=$(cat /tmp/osrelease | grep -v "NAME" | cut -f2 -d\" | awk '{print $1}')

if [ "$NAME" == "Debian" ]; then
	echo -e $PAPAYA "Nome.......................:"$GREEN $NAME;
else
	echo -e $PAPAYA "Nome.......................:"$RED "$NAME NAO E DEBIAN" $RSTCOLOR;
fi

if [ "$VERSION" == "9" ]; then
	echo -e $PAPAYA "Versao.....................:" $RSTCOLOR"$VERSION (Stretch) $RED FAZER UPGRADE" $RSTCOLOR;
elif [ "$VERSION" == "10" ]; then
	echo -e $PAPAYA "Versao.....................:" $RSTCOLOR"$VERSION (Buster)" $RSTCOLOR;
else
	echo -e $PAPAYA "Versao.....................:" $RED"$VERSION" $RSTCOLOR;
fi
  echo -e $PAPAYA "Hostname...................:" $RSTCOLOR $HOSTNAME $RSTCOLOR;

KERNELVERSION=$(cat /proc/sys/kernel/version | awk '{print $4}')
echo -e $PAPAYA "Kernel.....................:" $RSTCOLOR $KERNELVERSION;
echo -e $RSTCOLOR
