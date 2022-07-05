#!/bin/bash
USUARIO=`ls /home`

sudo tee /etc/sudoers.d/$USUARIO <<END
$USUARIO ALL=(ALL) NOPASSWD: ALL
END

function PrintBar() {
	RSTCLR=$(tput sgr0)
	VERMELHOG='\E[31;1m'
	AMARELOG='\E[33;1m'  
	BAR=`for i in $(seq 1 $(stty size | cut -d' ' -f2)); do echo -n "="; done; echo`
	echo $BAR
}

function ConfigureRepositories() {
	echo 'fastestmirror=1' | sudo tee -a /etc/dnf/dnf.conf
	echo 'deltarpm=true' | sudo tee -a /etc/dnf/dnf.conf
	echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf

	sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
	sudo dnf copr enable -y the4runner/firefox-dev
	sudo dnf update -y
}

function InstallDependencies() {
	sudo dnf install -y jq neovim mtr neofetch most zsh NetworkManager-l2tp-gnome lsd bat chrome-gnome-shell virt-manager gnome-extensions-app gnome-tweak-tool ffmpeg bpytop util-linux-user firefox-dev
}

function ConfigureGnome() {
	gsettings set org.gnome.desktop.interface show-battery-percentage true
	gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
	gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false
	gsettings set org.gnome.desktop.sound allow-volume-above-100-percent 'true'
	gsettings set org.gnome.mutter center-new-windows true
	gsettings set org.gnome.desktop.wm.preferences resize-with-right-button true
	gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
	gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
	gsettings set org.gnome.shell.app-switcher current-workspace-only true

	sudo -u gdm dbus-launch gsettings set org.gnome.desktop.interface show-battery-percentage true
	sudo -u gdm dbus-launch gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
	sudo -u gdm dbus-launch gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false
	sudo -u gdm dbus-launch gsettings set org.gnome.desktop.sound allow-volume-above-100-percent 'true'
	sudo -u gdm dbus-launch gsettings set org.gnome.mutter center-new-windows true
	sudo -u gdm dbus-launch gsettings set org.gnome.desktop.wm.preferences resize-with-right-button true
	sudo -u gdm dbus-launch gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
	sudo -u gdm dbus-launch gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

	gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/kitty/']"
	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/kitty/ name 'Kitty'
	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/kitty/ command 'kitty'
	gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/kitty/ binding '<Control><Alt>T'

	gsettings set org.gnome.desktop.search-providers disabled "['org.gnome.Contacts.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Boxes.desktop', 'org.gnome.Calculator.desktop', 'org.gnome.Calendar.desktop', 'org.gnome.Characters.desktop', 'org.gnome.clocks.desktop', 'org.gnome.Terminal.desktop', 'org.gnome.Software.desktop', 'org.gnome.Photos.desktop']"
	gsettings set org.gnome.shell favorite-apps "[]"
}

function InstallExtensions() {
	wget -N -q "https://raw.githubusercontent.com/cyfrost/install-gnome-extensions/master/install-gnome-extensions.sh" -O ./install-gnome-extensions.sh;
	chmod +x install-gnome-extensions.sh;
	./install-gnome-extensions.sh --enable 615 545 1007;
	rm -f ./install-gnome-extensions.sh;
}

function InstallMegasync() {
	wget https://mega.nz/linux/repo/Fedora_36/x86_64/megasync-Fedora_36.x86_64.rpm
	sudo dnf install -y megasync-Fedora_36.x86_64.rpm
	wget https://mega.nz/linux/repo/Fedora_36/x86_64/nautilus-megasync-Fedora_36.x86_64.rpm
	sudo dnf install -y nautilus-megasync-Fedora_36.x86_64.rpm
}

function InstallCopyq() {
	sudo dnf install -y copyq
	mkdir /home/$USUARIO/.config/autostart/
	{
		echo "[Desktop Entry]";
		echo "Name=CopyQ";
		echo "Icon=copyq";
		echo "GenericName=Clipboard Manager";
		echo "# Workaround / fix for issue #1526 that prevents a proper autostart of the tray icon in GNOME";
		echo "X-GNOME-Autostart-Delay=3";
		echo "# The rest is taken from Klipper application.";
		echo "Type=Application";
		echo "Terminal=false";
		echo "X-KDE-autostart-after=panel";
		echo "X-KDE-StartupNotify=false";
		echo "X-KDE-UniqueApplet=true";
		echo "Categories=Qt;KDE;Utility;";
		echo "GenericName[pt_BR]=Ferramenta da área de transferência";
		echo "Exec=env QT_QPA_PLATFORM=xcb copyq";
		echo "Hidden=false";
		echo "X-GNOME-Autostart-enabled=true"; } > /home/$USUARIO/.config/autostart/copyq.desktop
}

function InstallKitty() {
	sudo dnf install kitty  -y
	if [ ! -d /home/$USUARIO/.config/kitty/ ]; then
		mkdir -p /home/$USUARIO/.config/kitty/
	fi
	{
		echo 'export TERM=xterm-256color';
		echo 'hide_window_decoration yes';
		echo 'scrollback_lines -1';
		echo "";
		echo '# COLORS';
		echo 'color4 #15539e'
		echo "";
		echo '# KEYMAPS';
		echo 'map alt+left resize_window narrower';
		echo 'map alt+right resize_window wider';
		echo 'map alt+up resize_window taller';
		echo 'map alt+down resize_window shorter';
		echo 'map page_up scroll_page_up';
		echo 'map page_down scroll_page_down';
		echo 'map ctrl+down detach_tab';
		echo 'map f2 set_tab_title';
		echo "";
		echo '# ADWAITA THEME'
		echo 'foreground            #b8bcb9';
		echo 'background            #262626';
		echo 'selection_foreground  #1e1e1e';
		echo 'selection_background  #4a90d9';
		echo "";
		echo 'url_color #8be9fd';
		echo 'detect_url yes';
		echo 'url_style curly';
		echo "";
		echo '# CURSOR COLORS';
		echo 'cursor            #f8f8f2';
		echo 'cursor_text_color background';
		echo "";
		echo '# BORDERS';
		echo 'active_border_color #0d73cc';
		echo 'inactive_border_color #031769';
		echo "";
		echo '# TAB BAR';
		echo 'tab_bar_style powerline';
		echo 'tab_powerline_style slanted';
		echo 'tab_title_template {sup.index} {title}';
		echo 'tab_bar_min_tabs 1';
		echo 'tab_bar_margin_height 1.5 0.0';
		echo "";
		echo '# TAB COLORS';
		echo 'active_tab_foreground   #f8f8f2';
		echo 'active_tab_background   #0d73cc';
		echo 'active_tab_font_style   bold-italic';
		echo 'inactive_tab_foreground #b3b3b3';
		echo 'inactive_tab_background #10417b';
		echo 'inactive_tab_font_style normal';
		echo "";
		echo '# FONTS';
		echo 'bold_font        auto';
		echo 'italic_font      auto';
		echo 'bold_italic_font auto';
		echo "";
		echo 'linux_display_server x11'; } > /home/$USUARIO/.config/kitty/kitty.conf
	wget https://raw.githubusercontent.com/xaeioux/Useful-Shell/main/Install_PC/bpytop.conf
	mkdir /home/$USUARIO/.config/bpytop/
	mv bpytop.conf /home/$USUARIO/.config/bpytop/
}

function ConfigureZsh() {
		wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/LiberationMono/complete/Literation%20Sans%20Nerd%20Font%20Complete.ttf
		sudo cp Literation\ Sans\ Nerd\ Font\ Complete.ttf /home/$USUARIO/.local/share/fonts
		sudo mv Literation\ Sans\ Nerd\ Font\ Complete.ttf /usr/share/fonts
		mkdir /home/$USUARIO/.config/.zsh/
		git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /home/$USUARIO/.config/.zsh/powerlevel10k
		git clone https://github.com/zsh-users/zsh-autosuggestions /home/$USUARIO/.config/.zsh/zsh-autosuggestions
		git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /home/$USUARIO/.config/.zsh/zsh-syntax-highlighting
		{ echo 'if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then';
			echo 'source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"';
			echo 'fi';
			echo "";
			echo 'function set-term-title-precmd() {';
			echo 'emulate -L zsh';
			echo "print -rn -- \$'\e]0;'\${(V%):-'%~'}\$'\\a' >\$TTY";
			echo '}';
			echo 'function set-term-title-preexec() {';
			echo 'emulate -L zsh';
			echo "print -rn -- \$'\e]0;'\${(V)1}\$'\a' >\$TTY";
			echo '}';
			echo 'autoload -Uz add-zsh-hook';
			echo 'add-zsh-hook preexec set-term-title-preexec';
			echo 'add-zsh-hook precmd set-term-title-precmd';
			echo 'set-term-title-precmd';
			echo "";
			echo 'export PAGER="most"';
			echo "export LESS_TERMCAP_mb=\$'\e[1;32m'";
			echo "export LESS_TERMCAP_md=\$'\e[1;32m'";
			echo "export LESS_TERMCAP_me=\$'\e[0m'";
			echo "export LESS_TERMCAP_se=\$'\e[0m'";
			echo "export LESS_TERMCAP_so=\$'\e[01;33m'";
			echo "export LESS_TERMCAP_ue=\$'\e[0m'";
			echo "export LESS_TERMCAP_us=\$'\e[1;4;31m'";
			echo "";
			echo 'export TERM=xterm-256color';
			echo 'export EDITOR=nvim';
			echo "";
			echo 'alias cards="eog ~/Downloads/cards.png"';
			echo 'alias ls="lsd"';
			echo 'alias history="history -f"'
			echo 'alias more="bat"';
			echo 'alias less="bat"';
			echo 'alias top="bpytop"';
			echo 'alias hss="ssh -i ~/Documents/vaps.key"';
			echo 'alias vim="nvim"';
			echo "";
			echo 'export HISTFILE=~/.histfile';
			echo 'export HISTSIZE=1000000';
			echo 'export SAVEHIST=1000000';
			echo "";
			echo 'setopt HIST_REDUCE_BLANKS';
			echo 'setopt INC_APPEND_HISTORY_TIME';
			echo 'setopt EXTENDED_HISTORY';
			echo "";
			echo 'bindkey "^[[H"   beginning-of-line';
			echo 'bindkey "^[[F"   end-of-line';
			echo 'bindkey "^[[3~"  delete-char';
			echo 'bindkey "^[[1;5C" forward-word';
			echo 'bindkey "^[[1;5D" backward-word';
			echo 'bindkey "5~" kill-word';
			echo "";
			echo '# Use powerline';
			echo 'USE_POWERLINE="true"';
			echo 'source ~/.config/.zsh/powerlevel10k/powerlevel10k.zsh-theme';
			echo 'source ~/.config/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh';
			echo 'source ~/.config/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh';
			echo "";
			echo '# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.';
			echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh';
			echo "alias mkpass='cd ~ && ./.mkpass.sh'";
			echo "";
			echo 'function fix () {';
			echo 'CARDS=`"ls" ~/Downloads/Card* 1> /dev/null 2>&1 | wc -l 1> /dev/null 2>&1;`';
			echo ' if [ "$CARDS" -ge "1" 1> /dev/null 2>&1 ]; then';
			echo 'mv ~/Downloads/Card* ~/Downloads/cards.png 1> /dev/null 2>&1;';
			echo 'else';
			echo 'mv ~/Downloads/image_[0-9_]*T[0-9_]*Z.png ~/Downloads/cards.png 1> /dev/null 2>&1;';
			echo 'fi';
			echo 'cards';
			echo '}'; } > /home/$USUARIO/.zshrc
			cd /home/$USUARIO/;
			{ echo '#!/bin/bash';
				echo 'RANDOMPASS=$(head /dev/urandom| tr -dc a-zA-Z0-9 | head -c$1);';
				echo 'CONT=`expr $1 + 1`';
				echo 'BAR=''"$(seq -s '"'-' \$CONT|tr -d ""'[:digit:]')"'"';
				echo "CLR='\E[34;1m'";
				echo "RST='\E[0m'";
				echo "";
				echo "echo '+-'\$BAR'-+';";
				echo 'echo -e "| $CLR$RANDOMPASS$RST |";';
				echo "echo '+-'\$BAR'-+';"; } > /home/$USUARIO/.mkpass.sh
				chmod a+x .mkpass.sh
}

function InstallSkype() {
	sudo curl -o /etc/yum.repos.d/skype-stable.repo https://repo.skype.com/rpm/stable/skype-stable.repo
	sudo dnf install -y skypeforlinux
}

function InstallChromium() {
	sudo dnf install -y chromium
}

function InstallFlatpak() {
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	flatpak remote-modify --enable flathub
	flatpak install -y spotify
	flatpak install -y app/org.telegram.desktop/x86_64/stable
	flatpak install -y discord
	flatpak install -y phpstorm
}

function InstallFragments() {
	sudo dnf install -y fragments
}

function InstallVSCodium() {
	sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
	printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscodium.repo
	sudo dnf install -y codium
	codium --install-extension dcasella.monokai-plusplus
	codium --install-extension emmanuelbeziat.vscode-great-icons
}

function InstallAnydesk() {
wget -c 'https://download.anydesk.com/linux/anydesk_6.2.0-1_x86_64.rpm' -P /home/$USUARIO/Downloads
sudo rpm -ivh --nodeps /home/$USUARIO/Downloads/anydesk_6.2.0-1_x86_64.rpm

}

function InstallTeamviewer() {
	wget https://download.teamviewer.com/download/linux/teamviewer.x86_64.rpm
	sudo dnf install -y teamviewer.x86_64.rpm
}

function ConfigureGrub() {
	HWVENDOR=`hostnamectl | grep Vendor | awk {'print $3'}`
	sudo mkdir /boot/grub2/themes
	git clone https://github.com/AdisonCavani/distro-grub-themes.git

	if [[ "$HWVENDOR" == "Lenovo" ]]; then
		sudo cp -r distro-grub-themes/customize/lenovo /boot/grub2/themes
		sudo chown root:root /boot/efi/EFI/fedora/themes/lenovo -Rf
		sudo sed -i 's/GRUB_TERMINAL_OUTPUT="console"/#GRUB_TERMINAL_OUTPUT="console"/' /etc/default/grub
		echo 'GRUB_GFXMODE="1920x1080,auto"' | sudo tee -a /etc/default/grub
		echo 'GRUB_FONT="/boot/grub2/fonts/unicode.pf2"' | sudo tee -a /etc/default/grub
		echo 'GRUB_THEME="/boot/grub2/themes/lenovo/theme.txt"' | sudo tee -a /etc/default/grub
	else
		sudo cp -r distro-grub-themes/customize/fedora /boot/grub2/themes
		sudo chown root:root /boot/efi/EFI/fedora/themes/fedora -Rf
		sudo sed -i 's/GRUB_TERMINAL_OUTPUT="console"/#GRUB_TERMINAL_OUTPUT="console"/' /etc/default/grub
		echo 'GRUB_GFXMODE="1920x1080,auto"' | sudo tee -a /etc/default/grub
		echo 'GRUB_FONT="/boot/grub2/fonts/unicode.pf2"' | sudo tee -a /etc/default/grub
		echo 'GRUB_THEME="/boot/grub2/themes/fedora/theme.txt"' | sudo tee -a /etc/default/grub
	fi
	sudo grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
}

function CleanSys(){
	sudo dnf remove -y firefox gnome-shell-extension-background-logo
	rm -rf /home/$USUARIO/distro-grub-themes;
	rm -rf /home/$USUARIO/Downloads/*
}
echo "";
PrintBar
echo -e $VERMELHOG '    (\_/)                                ';
echo -e $VERMELHOG '   =(｡•ᵕ•｡)=  Configurando repositórios  ';
echo -e $VERMELHOG '    (乁\¥/)っ━☆ﾟ*･｡*･｡･:*:･ﾟ’★,｡･:*:･ﾟ’☆  '$RSTCLR
PrintBar
echo "";
ConfigureRepositories
PrintBar
echo -e $VERMELHOG '    (\_/)✧                               ';
echo -e $VERMELHOG '   =( ｡•̀ᴗ-)=  Instalando dependencias    ';
echo -e $VERMELHOG '    (乁\¥/)┘                             '$RSTCLR;
PrintBar
echo "";
InstallDependencies
PrintBar;
echo -e $VERMELHOG '    (\_/)                                ';
echo -e $VERMELHOG '   =( ╬ಠ益ಠ)=  Dando uns tapas no GNOME  ';
echo -e $VERMELHOG '    (  ง\¥/)ง                            '$RSTCLR;
PrintBar;
echo "";
ConfigureGnome
PrintBar;
echo -e $VERMELHOG '    (\_/)                                      ';
echo -e $VERMELHOG '   =( ٥ಠᴥಠ)=  Instalando algumas...extensões   ';
echo -e $VERMELHOG '    (ฅ\¥/ฅ)                                    '$RSTCLR;
PrintBar;
echo "";
InstallExtensions
PrintBar;
echo -e $VERMELHOG '    (\_/)                                      ';
echo -e $VERMELHOG '   =( ◕ヮ◕)=  Instalando MEGASYNC              ';
echo -e $VERMELHOG '    (>\¥/<)                                    '$RSTCLR;
PrintBar;
echo "";
InstallMegasync
PrintBar;
echo -e $VERMELHOG '    (\_/)                                       ';
echo -e $VERMELHOG '   =( ˶˘³˘˶)=  Instalando COPYQ                 ';
echo -e $VERMELHOG '    ( >\¥/<)                                    '$RSTCLR;
PrintBar;
echo "";
InstallCopyq
PrintBar;
echo -e $VERMELHOG '     /\_/\                                      ';
echo -e $VERMELHOG '   =( ʘﻌʘ )=  Instalando e configurando o KITTY ';
echo -e $VERMELHOG '  〜(ฅ\¥/ฅ)                                     '$RSTCLR;
PrintBar;
echo "";
InstallKitty
PrintBar;
echo -e $VERMELHOG '    (\_/)                                       ';
echo -e $VERMELHOG '   =( ⌐■-■)=  Configurando o ZSH                ';
echo -e $VERMELHOG '    (乁\¥/)´                                    '$RSTCLR;
PrintBar;
echo "";
ConfigureZsh
PrintBar;
echo -e $VERMELHOG '    (\_/)                                       ';
echo -e $VERMELHOG '   =(〣°ロ°)=  Instalando o SKYPE               ';
echo -e $VERMELHOG '    ( >\¥/<)                                    '$RSTCLR;
PrintBar;
echo "";
InstallSkype
PrintBar;
echo -e $VERMELHOG '    (\_/)                                       ';
echo -e $VERMELHOG '   =( ￣³￣)=  Instalando o CHROMIUM            ';
echo -e $VERMELHOG '    ( >\¥/<)                                    '$RSTCLR;
PrintBar;
echo "";
InstallChromium
PrintBar;
echo -e $VERMELHOG '    (\_/)                                       ';
echo -e $VERMELHOG '   =(  ˘､˘)=  Instalando alguns FLATPAKs        ';
echo -e $VERMELHOG '    ( ╮\¥/╭)                                    '$RSTCLR;
PrintBar;
InstallFlatpak
PrintBar;
echo -e $VERMELHOG '    (\_/)                                       ';
echo -e $VERMELHOG '   =(  ಠﭛಠ)=  Instalando o FRAGMENTS           ';
echo -e $VERMELHOG '    ( >\¥/<)                                    '$RSTCLR;
PrintBar;
InstallFragments
PrintBar;
echo -e $VERMELHOG '    (\_/)                                       ';
echo -e $VERMELHOG '   =( ￣＾￣)=  Configurando GRUB                ';
echo -e $VERMELHOG '    (  >\¥/<)                                   '$RSTCLR;
PrintBar;
ConfigureGrub
PrintBar;
echo -e $VERMELHOG '    (\_/)                                       ';
echo -e $VERMELHOG '   =( ಥ-ಥ)=  Instalando o VSCODIUM              ';
echo -e $VERMELHOG '    (>\¥/<)                                     '$RSTCLR;
PrintBar;
InstallVSCodium
PrintBar;
echo -e $VERMELHOG '    (\_/)                                       ';
echo -e $VERMELHOG '   =( >x<)=  Limpando o sistema                 ';
echo -e $VERMELHOG '    (>\¥/)占~~~~~~~~~~~~~~~~~~~                 '$RSTCLR;
PrintBar;
CleanSys

# SERÁ MESMO?
#InstallAnydesk
#InstallTeamviewer

chsh -s /bin/zsh $USUARIO

touch wooting.rules;
	{ echo '# Wooting One Legacy';
	echo 'SUBSYSTEM=="hidraw", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="ff01", MODE:="0660", GROUP="input"';
	echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="ff01", MODE:="0660", GROUP="input"';
	echo "";
	echo '# Wooting One update mode';
	echo 'SUBSYSTEM=="hidraw", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2402", MODE:="0660", GROUP="input"';
	echo "";
	echo '# Wooting One';
	echo 'SUBSYSTEM=="hidraw", ATTRS{idVendor}=="31e3", ATTRS{idProduct}=="1100", MODE:="0660", GROUP="input"';
	echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="31e3", ATTRS{idProduct}=="1100", MODE:="0660", GROUP="input"';
	echo "";
	echo '# Wooting One Alt-gamepad mode';
	echo 'SUBSYSTEM=="hidraw", ATTRS{idVendor}=="31e3", ATTRS{idProduct}=="1101", MODE:="0660", GROUP="input"';
	echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="31e3", ATTRS{idProduct}=="1101", MODE:="0660", GROUP="input"';
	echo "";
	echo '# Wooting One 2nd Alt-gamepad mode';
	echo 'SUBSYSTEM=="hidraw", ATTRS{idVendor}=="31e3", ATTRS{idProduct}=="1102", MODE:="0660", GROUP="input"';
	echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="31e3", ATTRS{idProduct}=="1102", MODE:="0660", GROUP="input"'; } > wooting.rules
	sudo mv wooting.rules /etc/udev/rules.d/
	sudo udevadm control --reload-rules && sudo udevadm trigger;

echo "";
echo '+--------------------------------------+';
echo '|              HEY! ♫•*¨*•.¸¸♪         |';
echo '|    (\_/)     Você por acaso é        |';
echo '|   =(  ø-ø)=  algum tipo de bardo ?   |';
echo '|    ( ³\¥/)´       >  S/N  <          |';
echo '+--------------------------------------+';
echo "";
read ANSWEAR
if [ "$ANSWEAR" == "S" ]; then
	sudo dnf install -y musescore;
fi
echo "";
echo '+---------------------------------------------+';
echo '|   ..zzZZ..   YAY!                           |';
echo '|    (\_/)     Todo o trabalho foi concluído  |';
echo '|   =(  ᴗ_ᴗ)=  com sucesso, agora sim, você   |';
echo '|    ( >\¥/)◜  pode aproveitar seu sistema !! |';
echo '+---------------------------------------------+';
echo "";

sudo /bin/rm /etc/sudoers.d/$USUARIO
sudo -k