#!/bin/bash
#
#   1 - Processor model
#   2 - Kernel architecture: 32 or 64 bits
#   3 - Processor architecture: <flags> 32 or 64 bits
#
#   Version:   3.0
#   Revision:  3.0
#   Mantainer: Xaeioux
#   License:   GPL
#===============================================================================


PROCMODEL=$(cat /proc/cpuinfo | grep 'model name' | uniq | awk '{print $4 $5 $6 $7}');
echo -e $PAPAYA "Modelo do Processador......: $RSTCOLOR $PROCMODEL";

KERNELARCH=$(getconf LONG_BIT);
if [ "$KERNELARCH" -gt 32 ]; then
	echo -e $PAPAYA "Arquitetura do Kernel......:$RSTCOLOR $KERNELARCH bits";
else
	echo -e $PAPAYA "Arquitetura do Kernel......:$RED $KERNELARCH bits (SISTEMA INSTALADO COM KERNEL 32 BITS)" $RSTCOLOR;
fi

PROCARCH=$(grep -o -w 'lm' /proc/cpuinfo | sort -u);
if [ "$PROCARCH" == "lm" ]; then
	echo -e $PAPAYA "Arquitetura do Processador.:$RSTCOLOR $PROCARCH";
else
	echo -e $PAPAYA "Arquitetura do Processador.:$RED tm (PROCESSADOR NAO SUPORTA 64 BITS)" $RSTCOLOR;
fi
