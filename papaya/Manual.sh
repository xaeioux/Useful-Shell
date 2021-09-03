#!/bin/bash
if [ "$(date +%k)" -ge 6 -a "$(date +%k)" -le 11 ];
 then
  CUMPRIMENTO="Bom dia"
 elif [ "$(date +%k)" -ge 12 -a "$(date +%k)" -le 17 ];
  then
  CUMPRIMENTO="Boa tarde"
 else CUMPRIMENTO="Boa noite"
fi

echo " ";
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
echo "         (\_/)   +---------+ $CUMPRIMENTO, você parece estar perdido";
echo "        =( °-°)= | H.o.W.? | leia o manual abaixo com muita atenção!";
echo "         (> ¥ )´ +---------+ lembre-se: com grandes poderes, grandes ";
echo -e "        ********         $REDG       R E S P O N S A B I L I D A D E S   ";
echo $RSTCOLOR"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
echo " ";
echo -e $GREENG " O papaya é um programa destinado a auxiliar o diagnóstico de um servidor";
echo "isso não isenta o olhar atento do técnico, use o programa somente como   "
echo "sugestão, nunca como veredito, sempre desconfie!"
echo -e $RSTCOLOR
echo -e $BOLD$PAPAYA"EXEMPLOS DE UTILIZAÇÃO..."
echo -e $RSTCOLOR"$RED#papaya parametro"
echo -e $RSTCOLOR"papaya cpu"
echo -e "papaya ram"
echo " "
echo -e $BOLD$PAPAYA"PARAMETROS... $RSTCOLOR "
echo -e $RED"cpu$RSTCOLOR     ~> Exibe dados básicos sobre o processador: nome, nucleos, arquitetura."
echo -e $RED"ram$RSTCOLOR     ~> Exibe dados básicos sobre a memória ram: total, livre, disponivel, "
echo "cache, em uso."
echo -e $RED"disco$RSTCOLOR   ~> Mostra informações sobre o disco: Partições, uso, ponto de montagem"
echo "também calcula a média de tempo de escrita em disco."
echo -e $RED"sistema$RSTCOLOR ~> Mostra dados sobre o sistema: Versao, Hostname, Versao do Kernel"
echo "Virtualização, Chassis e Sessões Logadas."
echo -e $RED"rede$RSTCOLOR    ~> Exibe dados básicos sobre a rede: Se o host está conectado a internet,"
echo "se o servidor DNS consegue resolver nomes, IP local do host, IP público do host,"
echo 'endereço(s) dos servidores de nomes.'
echo -e $RED"ixcsoft$RSTCOLOR ~> Verifica se os serviços fundamentais para o funcionamento do sistema"
echo 'estão funcionando normalmente (PHP,Nginx,Mysql,Freeradius,Fail2ban,Crontab)'
echo "elenca os 5 maiores consumidores de RAM e CPU."
echo -e $RED"help$RSTCOLOR    ~> ... Um manual contendo informações sobre o programa."
echo ""
echo -e $BOLD$PAPAYA"MAPA DE CORES... $RSTCOLOR"
echo -e $RED "- Textos em vermelho representam erros, precisa corrigir baseado no retorno"
echo -e $YELLOW "- Textos em amarelo representam pontos de atencao, nao estao nos padroes de otimizacao"
echo -e $GREEN "- Textos em verde indicam que o retorno esta conforme os padroes de otimizacao"
echo -e $PAPAYA "- Texto estatico, parte da organização do programa"$RSTCOLOR
