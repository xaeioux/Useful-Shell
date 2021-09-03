#!/bin/bash
#
#   1 - Test disk write speed
#   2 - Generate average write speed based on 3 tests
#
#   Version:   2.0
#   Revision:  3.0
#   Mantainer: Xaeioux
#   License:   GPL
#===============================================================================

function WriteTest(){
	(LANG=C dd if=/dev/zero of=escrita_$$ bs=64k count=16k conv=fdatasync && rm -f escrita* ) 2>&1 | awk -F, '{io=$NF} END { print io}' | sed 's/^[ \t]*//;s/[ \t]*$//'
}

echo -e $YELLOW"Testando escrita, pode demorar um pouco, aguarde..."$RSTCOLOR;
WRITEONE=$( WriteTest )
VALWRITEONE=$( echo $WRITEONE | awk -F'.' '{print $1}' | cut -d' ' -f1 )
if [ "$VALWRITEONE" -lt "4" ]; then
	echo -e $PAPAYA "Velocidade E/S(1):$GREEN $WRITEONE" $RSTCOLOR
elif [ "$VALWRITEONE" -lt "100" ]; then
	echo -e $PAPAYA "Velocidade E/S(1):$RED $WRITEONE" $RSTCOLOR
else
	echo -e $PAPAYA "Velocidade E/S(1):$GREEN $WRITEONE" $RSTCOLOR
fi
WRITETWO=$( WriteTest )
VALWRITETWO=$( echo $WRITETWO | awk -F'.' '{print $1}' | cut -d' ' -f1 )
if [ "$VALWRITETWO" -lt "4" ]; then
	echo -e $PAPAYA "Velocidade E/S(2):$GREEN $WRITETWO" $RSTCOLOR
elif [ "$VALWRITETWO" -lt "100" ]; then
	echo -e $PAPAYA "Velocidade E/S(2):$RED $WRITETWO" $RSTCOLOR
else
	echo -e $PAPAYA "Velocidade E/S(2):$GREEN $WRITETWO" $RSTCOLOR
fi
WRITETHR=$( WriteTest )
VALWRITETHR=$( echo $WRITETHR | awk -F'.' '{print $1}' | cut -d' ' -f1 )
if [ "$VALWRITETHR" -lt "4" ]; then
	echo -e $PAPAYA "Velocidade E/S(3):$GREEN $WRITETHR" $RSTCOLOR
elif [ "$VALWRITETHR" -lt "100" ]; then
	echo -e $PAPAYA "Velocidade E/S(3):$RED $WRITETHR" $RSTCOLOR
else
	echo -e $PAPAYA "Velocidade E/S(3):$GREEN $WRITETHR" $RSTCOLOR
fi
SUM=$(expr "$VALWRITEONE" + "$VALWRITETWO" + "$VALWRITETHR")
AVERAGE=$(expr $SUM / 3)
if [ $AVERAGE -lt "4" ]; then
	echo -e $PAPAYA "Media de escrita :$GREEN $AVERAGE GB/s" $RSTCOLOR;
elif [ $AVERAGE -lt "100" ]; then
	echo -e $PAPAYA "Media de escrita :$RED $AVERAGE MB/s (LENTIDAO NA ESCRITA)" $RSTCOLOR;
else
	echo -e $PAPAYA "Media de escrita :$GREEN $AVERAGE MB/s" $RSTCOLOR;
fi
echo -e $RSTCOLOR
