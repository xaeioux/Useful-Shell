#!/bin/bash
#
#   Script that validate if the processor was overloaded based on the load average and total cores
#
#   Features:
#   1 - CPU core count
#   2 - Load Average
#   3 - Processor load in the last five, ten and fifteen minutes
#
#   Version:   1.0
#   Revision:  3.1
#   Mantainer: Xaeioux
#   License:   GPL
#===============================================================================

CORES=$(awk -F: '/processor/ {core++} END {print core}' /proc/cpuinfo)
LOADAVERAGE=$(cat /proc/loadavg | awk '{print $1, $2, $3}')
echo -e $PAPAYA "Nucleos....................:"$RSTCOLOR $CORES;

FIVMIN=$(echo $LOADAVERAGE | awk '{print $1}' | cut -f1 -d, | cut -d'.' -f1)
TENMIN=$(echo $LOADAVERAGE | awk '{print $2}' | cut -f1 -d, | cut -d'.' -f1)
FIFMIN=$(echo $LOADAVERAGE | awk '{print $3}' | cut -f1 -d, | cut -d'.' -f1)

echo -e $PAPAYA "Load Average...............:"$RSTCOLOR $LOADAVERAGE;
echo '';
if [ "$FIVMIN" -gt "$CORES" ]; then
	echo -e $RED "Processador sobrecarregado nos ultimos 5 minutos"$RSTCOLOR;
else
	echo -e $GREEN "Processador nao esta sobrecarregado nos ultimos 5 minutos"$RSTCOLOR;
fi

if [ "$TENMIN" -gt "$CORES" ]; then
	echo -e $RED "Processador sobrecarregado nos ultimos 10 minutos"$RSTCOLOR;
else
	echo -e $GREEN "Processador nao esta sobrecarregado nos ultimos 10 minutos"$RSTCOLOR;
fi

if [ "$FIFMIN" -gt "$CORES" ]; then
	echo -e $RED "Processador sobrecarregado nos ultimos 15 minutos"$RSTCOLOR;
else
	echo -e $GREEN "Processador nao esta sobrecarregado nos ultimos 15 minutos"$RSTCOLOR;
fi
