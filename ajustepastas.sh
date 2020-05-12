#!/bin/bash -x
### BEGIN INIT INFO
# Provides:          ajustepastas 
# Required-Start:    $local_fs $remote_fs $network $syslog
# Required-Stop:     $local_fs $remote_fs $network $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: ajusta as pastas durante o boot
# Description:       ajusta as pastas durante o boot
### END INIT INFO
###############
#######################################################
# Para Ubuntu 16lts
#######################################################
####################################################
chkprog () {
	dpkg -l | grep "$1" 2>&1 >/dev/null
	[ $? == "1" ] && echo "Instalando $1" && sudo apt install $1 -y
	[ $? == "0" ] && echo "O programa $1 está instalado " 
}
#############################
chkprog "dialog"
chkprog "findimagedupes"
chkprog "fdupes"
chkprog "nomacs" 
chkprog "trash-cli"
chkprog "rsync"
###############
# AUTO INTEGRAR
###############
# nomeclatura
# cabecalho [script] [nome] [segundo endereço para cópia]
cabecalho "$0" "bashrc" "/etc/rc0.d"
#######################################################
### ajustando nomes de pastas
#######################################################
######### APAGANDO ARQUIVO
######### CHECANDO PASTAS
    for Npasta in "$HOME/Desktop" "$HOME/Downloads" "$HOME/Modelos" "$HOME/Público" "$HOME/Documentos" "$HOME/Música" "$HOME/Imagens" "$HOME/Vídeos";
	do
	sudo mkdir -p $Npasta
	sudo chown $USER:$USER $Npasta
	sudo chmod 1775 $Npasta
	alvo="$HOME/.config/user-dirs.dirs"
######### CHECANDO nomes pastas
	egrep -i $Npasta "$alvo" && echo "$?" 
######### apagando $alvo
	if [ $? -eq 1 ] ; then
######### criando e dando permissões pastas
	echo "ajustando endereços de pastas" 
	echo "$pst não encontrado corrigindo $alvo"
	sudo rm -f  "$alvo"

######### gerando novo arquivo
	sudo cat << EOF >  "$alvo"

#Este arquivo foi auto gerado pelo .bashrc
# 
XDG_DESKTOP_DIR="$HOME/Desktop"
XDG_DOWNLOAD_DIR="$HOME/Downloads"
XDG_TEMPLATES_DIR="$HOME/Modelos"
XDG_PUBLICSHARE_DIR="$HOME/Público"
XDG_DOCUMENTS_DIR="$HOME/Documentos"
XDG_MUSIC_DIR="$HOME/Música"
XDG_PICTURES_DIR="$HOME/Imagens"
XDG_VIDEOS_DIR="$HOME/Vídeos"

EOF


	fi
xdg-user-dirs-gtk-update
xdg-user-dirs-update
	done
#######################################################
### Corrigindo Nomes de pastas
#######################################################
	cd "$HOME" && mv  "$HOME/desktop" "$HOME/Desktop"
	cd "$HOME" && mv  "$HOME/modelos" "$HOME/Modelos"
	cd "$HOME" && mv  "$HOME/documentos" "$HOME/Documentos"
	cd "$HOME" && mv  "$HOME/downloads" "$HOME/Downloads"
	cd "$HOME" && mv  "$HOME/imagens" "$HOME/Imagens"
	cd "$HOME" && mv  "$HOME/público" "$HOME/Público"
	cd "$HOME" && mv  "$HOME/vídeos" "$HOME/Vídeos"
	cd "$HOME" && mv  "$HOME/música" "$HOME/Música"
#######################################################
