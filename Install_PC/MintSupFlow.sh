#!/bin/bash
function ExecutarTudo {
 InstalarAnydesk
 InstalarCopyq
 InstalarDbeaver
 InstalarDeepinscreenshot
 InstalarDeepinterminal
 InstalarDeepinscreenrecorder
 InstalarFilezilla
 InstalarAtom
 InstalarPlank
 InstalarQbittorrent
 InstalarTeamviewer
 InstalarSkype
 InstalarVirtualbox
 InstalarNumixicons
 InstalarWine
 InstalarSpotify
 InstalarVlc
 InstalarWireshark
 InstalarChrome
 InstalarDiscord
 }
function InstalarAnydesk {
 TAREFA=Anydesk
 URL="https://download.anydesk.com/linux/anydesk_6.0.0-1_amd64.deb"
 WgetGauge;
 sudo dpkg -i anydesk_6.0.0-1_amd64.deb >> log 2>/dev/null &
 DpkgGauge;
 CorrigeInstalacao;
 }
function InstalarCopyq {
 TAREFA=CopyQ
 sudo apt install copyq -y >> log 2>/dev/null &
 AptGauge;
 CorrigeInstalacao;
 }
function InstalarDbeaver {
 TAREFA=DBeaver
 URL="https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb"
 WgetGauge;
 sudo dpkg -i dbeaver-ce_latest_amd64.deb >> log 2>/dev/null &
 DpkgGauge;
 CorrigeInstalacao;
 }
 function InstalarDeepinscreenshot {
 TAREFA=Deepin_Screenshot
 sudo apt install deepin-screenshot -y >> log 2>/dev/null &
 AptGauge;
 CorrigeInstalacao;
 }
 function InstalarDeepinscreenrecorder {
 TAREFA=Deepin_Screen_Recorder
 sudo apt install deepin-screen-recorder -y >> log 2>/dev/null &
 AptGauge;
 CorrigeInstalacao;
 }
 function InstalarDeepinterminal {
 TAREFA=Deepin_Terminal
 sudo apt install deepin-terminal -y >> log 2>/dev/null &
 AptGauge;
 CorrigeInstalacao;
 }
 function InstalarFilezilla {
 TAREFA=Filezilla
 sudo apt install filezilla -y >> log 2>/dev/null &
 AptGauge;
 CorrigeInstalacao;
 }
 function InstalarAtom {
 TAREFA=Atom
 URL="https://atom.io/download/deb; -O atom-amd64.deb"
 WgetGauge;
 sudo dpkg -i atom-amd64.deb >> log 2>/dev/null &
 DpkgGauge;
 CorrigeInstalacao;
 }
 function InstalarPlank {
 TAREFA=Plank
 sudo apt install plank -y >> log 2>/dev/null &
 AptGauge;
 CorrigeInstalacao;
 }
 function InstalarQbittorrent {
 TAREFA=Qbittorrent
 sudo apt install qbittorrent -y >> log 2>/dev/null &
 AptGauge;
 CorrigeInstalacao;
 }
 function InstalarTeamviewer {
 TAREFA=TeamViewer
 URL="https://download.teamviewer.com/download/linux/teamviewer_amd64.deb"
 WgetGauge;
 sudo dpkg -i teamviewer_amd64.deb >> log 2>/dev/null &
 DpkgGauge;
 CorrigeInstalacao;
 }
 function InstalarSkype {
 TAREFA=Skype
 URL="https://go.skype.com/skypeforlinux-64.deb"
 WgetGauge
 sudo dpkg -i skypeforlinux-64.deb >> log 2>/dev/null &
 DpkgGauge;
 CorrigeInstalacao;
 }
 function InstalarVirtualbox {
 TAREFA=VirtualBox
 sudo apt install virtualbox -y >> log 2>/dev/null &
 AptGauge;
 CorrigeInstalacao;
 }
 function InstalarNumixicons {
 TAREFA=Numix
 sudo add-apt-repository -y ppa:numix/ppa >> log 2>/dev/null
 sudo apt update -y >> log 2>/dev/null
 sudo apt install numix-icon-theme-circle -y >> log 2>/dev/null &
 AptGauge;
 CorrigeInstalacao;
 }
 function InstalarWine {
 TAREFA=Wine
 sudo apt install wine -y >> log 2>/dev/null &
 AptGauge;
 CorrigeInstalacao;
 }
 function InstalarSpotify {
 TAREFA=Spotify
 sudo apt install spotify-client -y >> log 2>/dev/null &
 AptGauge;
 CorrigeInstalacao;
 }
 function InstalarVlc {
 TAREFA=VLC
 sudo apt install vlc -y >> log 2>/dev/null &
 AptGauge;
 CorrigeInstalacao;
 }
 function InstalarWireshark {
 TAREFA=Wireshark
 sudo apt install wireshark -y >> log 2>/dev/null &
 AptGauge;
 CorrigeInstalacao;
 }
 function InstalarChrome {
 TAREFA=Google_Chrome
 URL="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
 WgetGauge;
 sudo dpkg -i google-chrome-stable_current_amd64.deb >> log 2>/dev/null &
 DpkgGauge;
 CorrigeInstalacao;
 }
 function InstalarDiscord {
 TAREFA=Discord
 URL="https://discordapp.com/api/download?platform=linux&format=deb"
 WgetGauge
 sudo dpkg -i discord.deb >> log 2>/dev/null &
 DpkgGauge;
 CorrigeInstalacao;
 }

function AtualizaGeral {
echo $PASS | (sudo -S apt update && sudo -S apt upgrade && sudo -S apt full-upgrade && sudo -S apt dist-upgrade && sudo -S apt autoremove && sudo -S apt autoclean && sudo -S apt clean) >> log 2>/dev/null &
TAREFA=Atualizando
AptGauge
}

function CorrigeInstalacao {
echo S | sudo apt install -f
}

function AptGauge () {
 (i="0"
 while (true)
 do
  proc=$(ps aux | grep -v grep | grep -e "apt")
  if [[ "$proc" == "" ]]; then break; fi
  sleep 0.5
  echo $i
  i=$(expr $i + 1)
  done
  echo 100
  sleep 0.1) | whiptail --title "<( *-*)/" --gauge $TAREFA 8 78 0
}

function DpkgGauge () {
 (i="0"
 while (true)
 do
  proc=$(ps aux | grep -v grep | grep -e "dpkg")
  if [[ "$proc" == "" ]]; then break; fi
  sleep 0.5
  echo $i
  i=$(expr $i + 1)
  done
  echo 100
  sleep 0.1) | whiptail --title "\(*-* )>" --gauge $TAREFA 8 78 0
}

function WgetGauge () {
 wget --progress=dot "$URL" 2>&1 |\
 grep "%" |\
 sed -u -e "s,\.,,g" | awk '{print $2}' | sed -u -e "s,\%,,g"  | whiptail --title "\( *-* )/" --gauge "BAIXANDO" 8 78 0
}

function RemoverApps {
sudo apt remove --purge pix pix-data -y;
sudo apt remove --purge celluloid -y;
sudo apt remove --purge transmission-gtk transmission-common -y;
sudo apt remove --purge warpinator -y;
sudo apt remove --purge hexchat hexchat-common -y;
sudo apt remove --purge gnote -y;
sudo apt remove --purge rhythmbox -y >> log 2>/dev/null &
AptGauge;
}


#CUEIO
echo "  . .    .  .  . .  .   . .   .  .  .  " >> ~/.cueio
echo " . .  (\_/)    .   .  . .  .    .      " >> ~/.cueio
echo "  .  =( -.-)=     .  . .    NANI!? .   " >> ~/.cueio
echo " _____( >¥<)__________________________ " >> ~/.cueio

#INTERFACE
whiptail --title "MASTER BLASTER SCRIPT DE APLICATIVOS" --textbox ~/.cueio 10 43

#CRIA DIRETORIOS
cd ~
mkdir .apps;
cd .apps;

# SENHA DO LINUX
PASS=$(whiptail --title "=( .-.)=" --passwordbox "Digite sua senha para iniciar:" --fb 10 50 3>&1 1>&2 2>&3)
AtualizaGeral
#INSTALAÇÃO
escolha=$(whiptail --title "=( ^-^)=" --menu "Escolha o tipo de instalação desejada" --fb 10 50 3 \
 "1" "Completa" \
 "2" "Personalizada" \
 "3" "Cancelar" 3>&2 2>&1 1>&3)
  if [ $escolha = 1 ]; then
  ExecutarTudo
  elif [ $escolha = 2 ]; then
  whiptail --title "APLICATIVOS" --checklist --separate-output "Quais aplicativos você quer instalar?" 25 40 20 \
   "1" "Anydesk" OFF \
   "2" "CopyQ" OFF \
   "3" "DBeaver" OFF \
   "4" "Deepin Screenshot" OFF \
   "5" "Deepin Screen Recorder" OFF \
   "6" "Deepin Terminal" OFF \
   "7" "Filezilla" OFF \
   "8" "Atom" OFF \
   "9" "Plank" OFF \
   "10" "Qbittorrent" OFF \
   "11" "TeamViewer" OFF \
   "12" "Skype" OFF \
   "13" "Virtualbox" OFF \
   "14" "Numix Icons" OFF \
   "15" "Wine" OFF \
   "16" "Spotify" OFF \
   "17" "VLC" OFF \
   "18" "Wireshark" OFF \
   "19" "Google Chrome" OFF \
   "20" "Discord" OFF 2>resultado
 while read aplicacoes
 do
    case $aplicacoes in
    1)
    InstalarAnydesk;;
    2)
    InstalarCopyq;;
    3)
    InstalarDbeaver;;
    4)
    InstalarDeepinscreenshot;;
    5)
    InstalarDeepinscreenrecorder;;
    6)
    InstalarDeepinterminal;;
    7)
    InstalarFilezilla;;
    8)
    InstalarAtom;;
    9)
    InstalarPlank;;
    10)
    InstalarQbittorrent;;
    11)
    InstalarTeamviewer;;
    12)
    InstalarSkype;;
    13)
    InstalarVirtualbox;;
    14)
    InstalarNumixicons;;
    15)
    InstalarWine;;
    16)
    InstalarSpotify;;
    17)
    InstalarVlc;;
    18)
    InstalarWireshark;;
    19)
    InstalarChrome;;
    20)
    InstalarDiscord;;
    *)
    ;;
    esac
   done < resultado
else
  exit
fi
# BACKUP
if whiptail --title "PENSE BEM" --yes-button "Sim" --no-button "Nunca" --yesno "Você quer fazer BACKUP?" --fb 10 50
 then
 MEGAA=$(whiptail --title "EMAIL DO MEGA" --inputbox "Digite o nome do usuário do mega:" --fb 10 50 3>&1 1>&2 2>&3)
 MEGAP=$(whiptail --title "SENHA DO MEGA" --passwordbox "Digite a senha do usuário do mega:" --fb 10 50 3>&1 1>&2 2>&3)
 sudo apt install megatools -y;
 cd ~
 megaget /Root/bkp_trabalho.tar.gz /home/ -u $MEGAA -p $MEGAP
 tar -zxvf bkp_trabalho.tar.gz;
 echo "55 11 * * * cd /usr/bin/ && ./backup.sh" >> crontabs
 echo "55 17 * * * cd /usr/bin/ && ./backup.sh" >> crontabs
  USERN=`whoami`
  crontab -u $USERN crontabs;
  rm crontabs;
# INSTALAÇÃO DO BKP
  touch backup.sh;
  echo "cd ~" >> backup.sh;
  echo "rm bkp_trabalho.tar.gz;" >> backup.sh;
  echo "tar -zcvf bkp_trabalho.tar.gz Trabalho/ -R;" >> backup.sh;
  echo "megarm /Root/bkp_trabalho.tar.gz -u $MEGAA -p $MEGAP;" >> backup.sh;
  echo "megaput bkp_trabalho.tar.gz -u $MEGAA -p $MEGAP;" >> backup.sh;
  echo "XDG_RUNTIME_DIR=/run/user/$(id -u) notify-send BELEZA 'BACKUP ENVIADO PARA O MEGA';" >> backup.sh;
  chmod 777 backup.sh;
  sudo mv backup.sh /usr/bin
 rm ~/.cueio
 else
 whiptail --title "=( ò-ó)=" --msgbox "BAD CHOICE!!!" --fb 10 43
 rm ~/.cueio
fi
if whiptail --title "=( '-')=" --yes-button "Sim" --no-button "Não" --yesno "Você possui um teclado Wooting?" --fb 10 50
 then
  sudo apt install numlockx -y;
  sudo touch wooting.rules;
  echo '# Wooting One' >> wooting.rules;
  echo 'SUBSYSTEM=="hidraw", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="ff01", MODE:="0660", GROUP="input"'  >> wooting.rules;
  echo '# Wooting One update mode'  >> wooting.rules;
  echo 'SUBSYSTEM=="hidraw", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2402", MODE:="0660", GROUP="input"'  >> wooting.rules;
  sudo udevadm control --reload-rules && sudo udevadm trigger;
  sudo mv wooting.rules /etc/udev/rules.d/

 else
 whiptail --title "=( ô-õ)=" --msgbox "Sem Problemas!!!" --fb 10 43
fi
RemoverApps
AtualizaGeral
rm -rf .apps
