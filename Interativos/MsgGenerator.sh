#!/bin/bash
i=0

cd ~;
if test -d ".msgenerator";
 then
  cd ~/.msgenerator/
 else
  mkdir ~/.msgenerator/
  cd ~/.msgenerator/
fi

if test -f ".inst";
 then
  STATUS=1
 else
  touch .inst
  STATUS=0
fi

while [ "$STATUS" = 0 ]; do
   echo "Você quer instalar o programa? s/n"
   read STATUS
    if [ $STATUS = "s" ]; then
     cp ~/Downloads/ajuda.sh ~/.msgenerator/
     echo "Qual o comando você gostaria de usar para usar a ajuda?"
     read CMD
     echo 'alias' $CMD"='cd ~ && ./.msgenerator/ajuda.sh'">> ~/.bashrc
     echo "s" > .inst
     elif [ $STATUS = "n" ]; then
     echo "Você escolheu não instalar"
     echo "n" > .inst
     else
     echo "Opção inválida";
     STATUS=0
  fi
done

if [ "$(date +%k)" -ge 6 -a "$(date +%k)" -le 11 ];
 then
  HELLO="Bom dia"
 elif [ "$(date +%k)" -ge 12 -a "$(date +%k)" -le 17 ];
  then
  HELLO="Boa tarde"
 else HELLO="Boa noite"
fi

echo " ";
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
echo "  (\_/)         "$HELLO", vamos iniciar mais uma " ;
echo " =( ^^)=        implantação do PABX, YAY! Vim te ajudar";
echo "  (>  )´        com a apresentação, espero que goste";
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
echo " ";

if test -f ".hello";
 then
  TEC_NAME=`cat ~/.msgenerator/.hello`
  echo " "
  echo "Seja bem vindo de volta "$TEC_NAME;
 else
  touch ~/.msgenerator/.hello
   echo " "
   echo "Eu ainda não te conheço, qual é seu nome?"
   read TEC_NAME
   echo $TEC_NAME >> ~/.msgenerator/.hello
fi

i=0
while [ "$i" -eq 0 ]
do
 echo "Deseja colocar o nome do cliente? (s/n)";
  read CHOICE
   if [ $CHOICE = "s" ];
    then
     echo "Digite o nome do cliente:";
     read CUSTOMER_NAME;
     ((i++));
   elif [ $CHOICE = "n" ];
    then
     ((i++))
    else
      echo "Opção inválida.";
   fi
done
echo " ";
echo $HELLO $CUSTOMER_NAME "eu sou o" $TEC_NAME", responsável por implantar a telefonia no seu Opa! Suite.";
echo "Vamos agendar um horário para esse processo?";
echo "IMPORTANTE: Vamos precisar de acompanhamento de um técnico capacitado, caso precise configurar algum equipamento interno.";
echo "Para adiantar, preciso entender um pouco seu cenário:";
echo " "
echo "Como é sua estrutura de telefonia hoje?";
echo "Você recebe uma linha analógica ou digital?";
echo "Quantas linhas você tem de entrada?";
echo "Você possui algum equipamento ou sistema para integrar com o Opa!?";
echo "Aguardo sua confirmação para podermos dar sequência.";
