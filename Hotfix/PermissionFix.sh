#!/bin/bash
#+--------------------+
#|       TARGETS      |
#+--------------------+
FILES=(php7.3-fpm.log dpkg.log syslog user.log auth.log daemon.log debug  fail2ban.log kern.log mail.log messages alternatives.log faillog fontconfig.log btmp wtmp lastlog)
UNIT=(collectd elasticsearch php7.3-fpm rsync	ssh	cron fail2ban memcached	nginx	rsyslog	freeradius mysql ntp)
DIRECTORY=(private installer apt nginx ntpstats freeradius mysql elasticsearch)
OWNER_GROUP=(adm root utmp ntp freerad mysql elasticsearch)
MODS=(600 640 644 660 664 700 755 2750)
#+--------------------+
#|      INTERFACE     |
#+--------------------+
BAR="echo +-----------------------------------------------------------+"
GREEN="\E[32m ✔ SUCESSO!"
GREENG="\E[32;1m"
RED="\E[31m ✘ FALHA!!!"
REDG="\E[31;1m"
YELLOW="\E[33;1m"
WHITE="\E[1m\E[107m\E[30m"
DGRAY="\E[1m\E[100m\E[30m"
LGRAY="\E[1m\E[47m\E[30m"
RSTCLR="\E[0m"
UNDER="\E[4m"
COLOR=("$GREEN" "$RED")

function ZVARS(){
	ERR_CONT=0
	DERR_CONT=0
	TRYDERR_CONT=0
	CONT=0
	EXIT_CODE=0
}
#+-----------------------------------------+
#| CONFERE O RETORNO DE SAIDA DOS COMANDOS |
#+-----------------------------------------+
function CHECK_RETURN() {
	if [ "$?" -eq "0" ]; then
		export COLRCONT='0'
	else
		export COLRCONT='1'
		case "$EVAL" in
			0)
				let ERR_CONT++
				;;
			1)
				let DERR_CONT++
				;;
		esac
	fi
}

cd /var/log || exit;
$BAR; echo -e "| $WHITE     Corrigindo permissoes dos "$UNDER"ARQUIVOS$RSTCLR$WHITE em /var/log/     $RSTCLR |";$BAR;
date;
ZVARS
while [ "$CONT" -ne "17" ]; do
	if [ "$CONT" -eq "0" ]; then
		OWNER_CONT='1'
		GROUP_CONT='1'
		PERMS_CONT='0'
	elif [ "$CONT" -lt "2" ]; then
		OWNER_CONT='1'
		GROUP_CONT='1'
		PERMS_CONT='1'
	elif [ "$CONT" -lt "11" ]; then
		OWNER_CONT='1'
		GROUP_CONT='0'
		PERMS_CONT='1'
	elif [ "$CONT" -lt "14" ]; then
		OWNER_CONT='1'
		GROUP_CONT='1'
		PERMS_CONT='2'
	elif [ "$CONT" -eq "14" ]; then
		OWNER_CONT='1'
		GROUP_CONT='2'
		PERMS_CONT='3'
	elif [ "$CONT" -lt "17" ]; then
		OWNER_CONT='1'
		GROUP_CONT='2'
		PERMS_CONT='4'
	else
		exit;
	fi

	if [ -f ${FILES[$CONT]} ]; then
		chown ${OWNER_GROUP[$OWNER_CONT]}:${OWNER_GROUP[$GROUP_CONT]} ${FILES[$CONT]} 2>/dev/null; CHECK_RETURN;
		echo -e "${COLOR[$COLRCONT]}$RSTCLR - $DGRAY chown ${OWNER_GROUP[$OWNER_CONT]}:${OWNER_GROUP[$GROUP_CONT]} ${FILES[$CONT]} $RSTCLR";
		chmod ${MODS[$PERMS_CONT]} ${FILES[$CONT]} 2>/dev/null; CHECK_RETURN;
		echo -e "${COLOR[$COLRCONT]}$RSTCLR - $LGRAY chmod ${MODS[$PERMS_CONT]} ${FILES[$CONT]} $RSTCLR";
	else
		EVAL='1'
		let TRYDERR_CONT++
		touch ${FILES[$CONT]} 2>/dev/null; CHECK_RETURN;
		EVAL='0'
		echo -e "${COLOR[$COLRCONT]}$RSTCLR - $WHITE touch ${FILES[$CONT]} $RSTCLR";
		chown ${OWNER_GROUP[$OWNER_CONT]}:${OWNER_GROUP[$GROUP_CONT]} ${FILES[$CONT]} 2>/dev/null; CHECK_RETURN;
		echo -e "${COLOR[$COLRCONT]}$RSTCLR - $DGRAY chown ${OWNER_GROUP[$OWNER_CONT]}:${OWNER_GROUP[$GROUP_CONT]} ${FILES[$CONT]} $RSTCLR";
		chmod ${MODS[$PERMS_CONT]} ${FILES[$CONT]} 2>/dev/null; CHECK_RETURN;
		echo -e "${COLOR[$COLRCONT]}$RSTCLR - $LGRAY chmod ${MODS[$PERMS_CONT]} ${FILES[$CONT]} $RSTCLR";
	fi
	let CONT++
done

if [ "$TRYDERR_CONT" -eq "0" ]; then
	$BAR;echo -e "|              $GREENG!!! Nenhum "$UNDER"ARQUIVO$RSTCLR$GREENG criado !!!$RSTCLR                |";$BAR;
elif [ "$DERR_CONT" -eq "0" ]; then
	$BAR;echo -e "|          $GREENG!!! Concluido criacao dos "$UNDER"ARQUIVOS$RSTCLR$GREENG !!!$RSTCLR           |";$BAR;
elif [ "$DERR_CONT" -lt "$TRYDERR_CONT" ]; then
	$BAR;echo -e "|            $YELLOW!!! Erros ao criar "$UNDER"ARQUIVOS$RSTCLR$YELLOW !!!$RSTCLR              |";$BAR;
else
	$BAR;echo -e "|  $REDG         !!! Impossivel criar os "$UNDER"ARQUIVOS$RSTCLR$REDG !!!          $RSTCLR  |";$BAR;
fi

if [ "$ERR_CONT" -eq "0" ]; then
	$BAR;echo -e "|   $GREENG!!! Concluido alteracao de permissao dos "$UNDER"ARQUIVOS$RSTCLR$GREENG !!!$RSTCLR   |";$BAR;
elif [ "$ERR_CONT" -lt "34" ]; then
	$BAR;echo -e "| $YELLOW   !!! Erros ao alterar as permissoes dos "$UNDER"ARQUIVOS$RSTCLR$YELLOW !!!$RSTCLR    |";$BAR;
else
	$BAR;echo -e "|   $REDG!!! Impossivel alterar as permissoes dos "$UNDER"ARQUIVOS$RSTCLR$REDG !!!$RSTCLR   |";$BAR;
fi

$BAR;echo -e "| $WHITE    Corrigindo permissoes dos "$UNDER"DIRETORIOS$RSTCLR$WHITE em /var/log/    $RSTCLR |";$BAR;
date
ZVARS
while [ "$CONT" -ne "8" ]; do
	if [ "$CONT" -eq "0" ]; then
		OWNER_CONT='1'
		GROUP_CONT='1'
		PERMS_CONT='5'
	elif [ "$CONT" -lt "3" ]; then
		OWNER_CONT='1'
		GROUP_CONT='1'
		PERMS_CONT='6'
	elif [ "$CONT" -eq "3" ]; then
		OWNER_CONT='1'
		GROUP_CONT='0'
		PERMS_CONT='6'
	elif [ "$CONT" -eq "4" ]; then
		OWNER_CONT='3'
		GROUP_CONT='3'
		PERMS_CONT='6'
	elif [ "$CONT" -eq "5" ]; then
		OWNER_CONT='4'
		GROUP_CONT='0'
		PERMS_CONT='6'
	elif [ "$CONT" -eq "6" ]; then
		OWNER_CONT='5'
		GROUP_CONT='0'
		PERMS_CONT='7'
	elif [ "$CONT" -eq "7" ]; then
		OWNER_CONT='6'
		GROUP_CONT='6'
		PERMS_CONT='7'
	else
		exit;
	fi

	if [ -d ${DIRECTORY[$CONT]} ]; then
		EVAL='0'
		chown ${OWNER_GROUP[$OWNER_CONT]}:${OWNER_GROUP[$GROUP_CONT]} ${DIRECTORY[$CONT]} 2>/dev/null; CHECK_RETURN;
		echo -e "${COLOR[$COLRCONT]}$RSTCLR - $DGRAY chown ${OWNER_GROUP[$OWNER_CONT]}:${OWNER_GROUP[$GROUP_CONT]} ${DIRECTORY[$CONT]} $RSTCLR";
		chmod ${MODS[$PERMS_CONT]} ${DIRECTORY[$CONT]} 2>/dev/null; CHECK_RETURN;
		echo -e "${COLOR[$COLRCONT]}$RSTCLR - $LGRAY chmod ${MODS[$PERMS_CONT]} ${DIRECTORY[$CONT]} $RSTCLR";
	else
		EVAL='1'
		let TRYDERR_CONT++
		mkdir ${DIRECTORY[$CONT]} 2>/dev/null; CHECK_RETURN;
		EVAL='0'
		echo -e "${COLOR[$COLRCONT]}$RSTCLR - $WHITE mkdir ${DIRECTORY[$CONT]} $RSTCLR";
		chown ${OWNER_GROUP[$OWNER_CONT]}:${OWNER_GROUP[$GROUP_CONT]} ${DIRECTORY[$CONT]} 2>/dev/null; CHECK_RETURN;
		echo -e "${COLOR[$COLRCONT]}$RSTCLR - $DGRAY chown ${OWNER_GROUP[$OWNER_CONT]}:${OWNER_GROUP[$GROUP_CONT]} ${DIRECTORY[$CONT]} $RSTCLR";
		chmod ${MODS[$PERMS_CONT]} ${DIRECTORY[$CONT]} 2>/dev/null; CHECK_RETURN;
		echo -e "${COLOR[$COLRCONT]}$RSTCLR - $LGRAY chmod ${MODS[$PERMS_CONT]} ${DIRECTORY[$CONT]} $RSTCLR";
	fi
	let CONT++
done

if [ "$TRYDERR_CONT" -eq "0" ]; then
	$BAR;echo -e "|             $GREENG!!! Nenhum "$UNDER"DIRETORIO$RSTCLR$GREENG criado !!!$RSTCLR               |";$BAR;
elif [ "$DERR_CONT" -eq "0" ]; then
	$BAR;echo -e "|         $GREENG!!! Concluido criacao dos "$UNDER"DIRETORIOS$RSTCLR$GREENG !!!$RSTCLR          |";$BAR;
elif [ "$DERR_CONT" -lt "$TRYDERR_CONT" ]; then
	$BAR;echo -e "|            $YELLOW!!! Erros ao criar "$UNDER"DIRETORIOS$RSTCLR$YELLOW !!!$RSTCLR              |";$BAR;
else
	$BAR;echo -e "|  $REDG        !!! Impossivel criar os "$UNDER"DIRETORIOS$RSTCLR$REDG !!!         $RSTCLR  |";$BAR;
fi

if [ "$ERR_CONT" -eq "0" ]; then
	$BAR;echo -e "|  $GREENG!!! Concluido alteracao de permissao dos "$UNDER"DIRETORIOS$RSTCLR$GREENG !!!$RSTCLR  |";$BAR;
elif [ "$ERR_CONT" -lt "16" ]; then
	$BAR;echo -e "|   $YELLOW!!! Erros ao alterar as permissoes dos "$UNDER"DIRETORIOS$RSTCLR$YELLOW !!!$RSTCLR   |";$BAR;
else
	$BAR;echo -e "|  $REDG!!! Impossivel alterar as permissoes dos "$UNDER"DIRETORIOS$RSTCLR$REDG !!!$RSTCLR  |";$BAR;
fi

ZVARS
$BAR; echo -e "| $WHITE     REINICIAR OS "$UNDER"SERVICOS$RSTCLR$WHITE ? Digite: '"$REDG$UNDER"SIM$RSTCLR$WHITE' ou '"$REDG$UNDER"NAO$RSTCLR$WHITE'      $RSTCLR |";$BAR;
echo -ne "Resposta: " && read ANS
if [ "$ANS" == "SIM" ]; then
	while [ "$CONT" -le "11" ]; do
		systemctl restart ${UNIT[$CONT]} 2>/dev/null; CHECK_RETURN;
		echo -e "${COLOR[$COLRCONT]}$RSTCLR - $LGRAY systemctl restart ${UNIT[$CONT]} $RSTCLR";
		let CONT++
	done
else
	EXIT_CODE=5
fi

if [ "$EXIT_CODE" -eq "5" ]; then
	$BAR;echo -e "|     $REDG                 !!! "$UNDER"SAINDO$RSTCLR$REDG !!!$RSTCLR                       |";$BAR;
elif [ "$ERR_CONT" -eq "0" ]; then
	$BAR;echo -e "|          $GREENG!!! Concluido restart dos "$UNDER"SERVICOS$RSTCLR$GREENG !!!$RSTCLR           |";$BAR;
elif [ "$ERR_CONT" -lt "12" ]; then
	$BAR;echo -e "|           $YELLOW!!! Erros ao reiniciar os "$UNDER"SERVICOS$RSTCLR$YELLOW !!!$RSTCLR          |";$BAR;
else
	$BAR;echo -e "|     $REDG!!! Impossivel reiniciar os servicos "$UNDER"SERVICOS$RSTCLR$REDG !!!$RSTCLR     |";$BAR;
fi
