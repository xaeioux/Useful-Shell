#!/bin/bash
#
#   1 - Private IP
#   2 - Public IP
#   3 - DNS servers
#
#   Version:   1.0
#   Revision:  3.0
#   Mantainer: Xaeioux
#   License:   GPL
#===============================================================================

ping -c 1 45.174.128.1 &>/dev/null && echo -e $PAPAYA "Internet...................:$RSTCOLOR Conectado" || echo -e $RED "Internet...........: Sem internet $RSTCOLOR"
ping -c 1 sistema.ixcsoft.com.br &>/dev/null && echo -e $PAPAYA "DNS........................:$RSTCOLOR Resolvendo" || echo -e $RED "DNS NAO RESOLVE $RSTCOLOR"

INTERNALIP=$(ip route get 1.1.1.1 | awk {'print $7'})
echo -e $PAPAYA "IP Interno.................:"$RSTCOLOR $INTERNALIP;
EXTERNALIP=$(curl -s ipecho.net/plain;echo)
echo -e $PAPAYA "IP Externo.................:"$RSTCOLOR $EXTERNALIP;
NAMESERVER=$(cat /etc/resolv.conf | grep "nameserver" | awk '{print $2}')
echo -e $PAPAYA "Servidores DNS.............:"$RSTCOLOR $NAMESERVER;
echo -e $RSTCOLOR
