#!/bin/bash
INPUT="./arquivo"

BAR="echo +--------------------------------+"
GREEN="\E[32;1m ✔"
RED="\E[31;1m ✘"
WHITE="\E[1m\E[107m\E[30m"
DGRAY="\E[1m\E[100m\E[30m"
LGRAY="\E[1m\E[47m\E[30m"
RSTCLR="\E[0m"
UNDER="\E[4m"

echo "Para qual email devo enviar o status?"
read MAIL

while IFS= read -r LINE
do
echo -e $UNDER"$LINE"$RSTCLR
DATE_START=`curl -vk --silent "$LINE" 2>&1 | grep "start date" | awk '{print $2, $5, $4, $7}'`
DATE_EXPIRE=`curl -vk --silent "$LINE" 2>&1 | grep "expire date" | awk '{print $2, $5, $4, $7}'`
TODATE=`date | awk '{print $1, $2, $3, $6}'`

DAY_TODAY=`echo $TODATE | awk '{print $3}'`
MONTH_TODAY=`echo $TODATE | awk '{print $2}'`
YEAR_TODAY=`echo $TODATE | awk '{print $4}'`

DAY_START=`echo $DATE_START | awk '{print $2}'`
MONTH_START=`echo $DATE_START | awk '{print $3}'`
YEAR_START=`echo $DATE_START | awk '{print $4}'`

DAY_EXPIRE=`echo $DATE_EXPIRE | awk '{print $2}'`
MONTH_EXPIRE=`echo $DATE_EXPIRE | awk '{print $3}'`
YEAR_EXPIRE=`echo $DATE_EXPIRE | awk '{print $4}'`

DATE_STARTCOMP="$YEAR_START-$MONTH_START-$DAY_START"
DATE_EXPIRECOM="$YEAR_EXPIRE-$MONTH_EXPIRE-$DAY_EXPIRE"
DATE_TODAY="$YEAR_TODAY-$MONTH_TODAY-$DAY_TODAY"

echo -e "$DGRAY Validado em:$RSTCLR $DATE_STARTCOMP"
echo -e "$LGRAY Expirado em:$RSTCLR $DATE_EXPIRECOM"
echo -e "$DGRAY Data Atual :$RSTCLR $DATE_TODAY"

if [ "$DATE_EXPIRECOM" \> "$DATE_STARTCOMP" ]; then
	$BAR;echo -e "|        $GREEN SSL VALIDADO$RSTCLR         |";$BAR;
	printf "Subject: SUCESSO\nTUDO CERTO COM O SSL NO DOMINIO $LINE" | msmtp -a default $MAIL
	let TESTANDO++
else
	$BAR;echo -e "|       $RED SSL EXPIRADO$RSTCLR          |";$BAR;
	printf "Subject: FALHA\nSSL NAO ESTA VALIDADO NO DOMINIO $LINE" | msmtp -a default $MAIL
	let TESTANDO++
fi

done < "$INPUT"
