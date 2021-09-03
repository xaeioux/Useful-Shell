#!/bin/bash
#
#   1 - Validates how many processes are running per service
#   2 - Validates if all the units are running
#   3 - Ranks the top 5 memory and cpu consumers
#
#   Version:   3.0
#   Revision:  3.0
#   Mantainer: Xaeioux
#   License:   GPL
#===============================================================================

function Top5(){
	top -b -n1 -o $INDEX | sort -k1 -r -n | head -5 >/tmp/procs
	i=0
	while read PROCS; do
		if [ $INDEX == "%CPU" ]; then
			RESOURCEUSE=`echo "$PROCS" | awk '{print $9}' | cut -d. -f1`
		else
			RESOURCEUSE=`echo "$PROCS" | awk '{print $10}' | cut -d. -f1`
		fi
		if [ $RESOURCEUSE -gt $compara ]; then
			echo -e $RED "Processo $i: $PROCS" $RSTCOLOR;
		else
			echo -e $GREEN "Processo $i: $PROCS" $RSTCOLOR;
		fi
		i=$(($i + 1))
	done </tmp/procs;
}

PROCPHP=$(ps aux | grep php-fpm | wc -l)
PROCNODE=$(ps aux | grep node | wc -l)
PROCMSQL=$(ps aux | grep mysql | wc -l)
PROCFRADIUS=$(ps aux | grep radius | wc -l)
PROCF2BAN=$(ps aux | grep fail2 | wc -l)
PROCNGINX=$(ps aux | grep nginx | wc -l)

EXPRPHP=$(expr $PROCPHP - 1)
EXPRNODE=$(expr $PROCNODE - 1)
EXPRMYSQL=$(expr $PROCMSQL - 1)
EXPRFRADIUS=$(expr $PROCFRADIUS - 1)
EXPRF2BAN=$(expr $PROCF2BAN - 1)
EXPRNGINX=$(expr $PROCNGINX - 1)

UNITPHP=$(systemctl status php7.* | grep "Active:" | awk '{print $2 $3}')
UNITNGINX=$(systemctl status nginx | grep "Active:" | awk '{print $2 $3}')
UNITFRADIUS=$(systemctl status freeradius | grep "Active:" | awk '{print $2 $3}')
UNITMSQL=$(systemctl status mysql| grep "Active:" | awk '{print $2 $3}')
UNITF2BAN=$(systemctl status fail2ban | grep "Active:" | awk '{print $2 $3}')
UNITCRON=$(systemctl status cron | grep "Active:" | awk '{print $2 $3}')

echo -e $PAPAYA "php-fpm....................:$RSTCOLOR" $EXPRPHP;
echo -e $PAPAYA "Node.......................:$RSTCOLOR" $EXPRNODE;
echo -e $PAPAYA "Mysql......................:$RSTCOLOR" $EXPRMYSQL;
echo -e $PAPAYA "Freeradius.................:$RSTCOLOR" $EXPRFRADIUS;
echo -e $PAPAYA "Fail2ban...................:$RSTCOLOR" $EXPRF2BAN;
echo -e $PAPAYA "Nginx......................:$RSTCOLOR" $EXPRNGINX;

echo '';

echo -e $BOLD$PAPAYA"Status dos servicos..." $RSTCOLOR

if [ $UNITPHP == "active(running)" ]; then
	echo -e $PAPAYA "PHP........................:$RSTCOLOR $UNITPHP";
else
	echo -e $PAPAYA "PHP........................:$RED $UNITPHP ARRUMAR PHP$RSTCOLOR";
fi

if [ $UNITNGINX == "active(running)" ]; then
	echo -e $PAPAYA "Nginx......................:$RSTCOLOR $UNITNGINX";
else
	echo -e $PAPAYA "Nginx......................:$RED $UNITNGINX ARRUMAR NGINX$RSTCOLOR";
fi

if [ $UNITMSQL == "active(running)" ]; then
	echo -e $PAPAYA "Mysql......................:$RSTCOLOR $UNITMSQL";
else
	echo -e $PAPAYA "Mysql......................:$RED $UNITMSQL ARRUMAR MYSQL$RSTCOLOR";
fi

if [ $UNITFRADIUS == "active(running)" ]; then
	echo -e $PAPAYA "Freeradius.................:$RSTCOLOR $UNITFRADIUS";
else
	echo -e $PAPAYA "Freeradius.................:$RED $UNITFRADIUS ARRUMAR FREERADIUS$RSTCOLOR";
fi

if [ $UNITF2BAN == "active(running)" ]; then
	echo -e $PAPAYA "Fail2ban...................:$RSTCOLOR $UNITF2BAN";
else
	echo -e $PAPAYA "Fail2ban...................:$RED $UNITF2BAN ARRUMAR FAIL2BAN$RSTCOLOR";
fi

if [ $UNITCRON == "active(running)" ]; then
	echo -e $PAPAYA "Crontab....................:$RSTCOLOR $UNITCRON";
else
	echo -e $PAPAYA "Crontab....................:$RED $UNITCRON ARRUMAR CRONTAB$RSTCOLOR";
fi


echo ''
echo -e $PAPAYA"uso CPU" $RSTCOLOR
INDEX='%CPU'
compara=50
Top5
echo ''
echo -e $PAPAYA"uso MEM" $RSTCOLOR
INDEX='%MEM'
compara=25
Top5
echo -e $RSTCOLOR
