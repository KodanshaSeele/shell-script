#!/bin/bash -x
corrigepastas () {
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
}

corrigepastas 

alias ls='ls --color=auto'
         alias atualizar='sudo apt-get update'
                         alias instalar='sudo apt-get install "$1"'
                                        alias grep='grep --colour=auto'
ytm () {
	dpkg -l | grep "youtube-dl" 2>&1 >/dev/null
	[ $? == "1" ] && echo "youtube-dl nao instalado, favor corrigir"
	chkpst "$HOME/Música" || echo "nao foi possivel acessar a pasta /home/$USER/Música, favor verificar" 	
    	test $# -gt 0 || echo "utilize ytm "[link da musica]""
    	test $# -gt 0 && youtube-dl --ignore-errors --extract-audio --audio-format mp3 --output "%(title)s.%(ext)s" "$1"
}

ytml () {
	dpkg -l | grep "youtube-dl" 2>&1 >/dev/null
	[ $? == "1" ] && echo "youtube-dl nao instalado, favor corrigir"
	chkpst "$HOME/Música" || echo "nao foi possivel acessar a pasta /home/$USER/Música, favor verificar" 
	test $# -gt 0 || echo "utilize ytml "[link da playlist]""
	test $# -gt 0 && youtube-dl --ignore-errors --extract-audio --audio-format mp3 --output "%(title)s.%(ext)s" --yes-playlist "$1"
}

chk () {
	echo "Checando -- $1"
	dpkg -l | grep "$1" 2>&1 >/dev/null
	[ $? == "1" ] && echo "Instalando $1" && sudo apt install $1 -y
	[ $? == "0" ] && echo "O programa $1 está instalado "
}


permissao () {
	sudo chmod -c 755 "$1"
	case "$?" in
	0) echo "$1 - permissao --ok" > /dev/null 2>&1 ;;
	1) echo "$1 - permissao --erro"
	exit ;;
	esac
}

###########




wait () {
chars="//--\\||"

while :; do
  for (( i=0; i<${#chars}; i++ )); do
    sleep 0.1
    echo -en "${chars:$i:1}" "\r"
  done
done
}

chkpst() {
sudo mkdir -p "$1" || {  clear && echo "Erro: criacao pasta "$1" mal sucedida" >&2; exit; }
permissao "$1"
permissao "$1"
}


copiar () {
sudo rsync -Haruv --progress "$1" "$2" || {  clear && echo ""$1 copia para $2"Erro: copia mal sucedida" >&2; exit; }
	}

mover () {
echo "$1 movendo para $2"
sudo rsync -Haruv --progress --remove-source-files "$1" "$2" || { clear && echo ""$1 movendo para $2" Erro: movimento mal sucedido " >&2; exit; }

	}

testarMover () {
sudo rsync -Haruv --dry-run --progress --remove-source-files "$1" "$2" || { echo "Erro: teste mover mal sucedida" >&2; exit; }
	}

testarCopiar () {
sudo rsync -Haruv --dry-run --progress "$1" "$2" || { echo "Erro: teste copia mal sucedida" >&2; exit; }
	}
integrar () {
permissao "$0"
chkpst "$1"
copiar $0 "/bin/"
copiar $0 ""$1"/"
permissao ""$1"/"
clear
}
 integrar "/home/anderson/.neosys/1/doc/sh$"


# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# Set title to "Peppermint Terminal"
PROMPT_COMMAND='echo -ne "\033]0;Peppermint Terminal\007"'

# System-wide .bashrc file for interactive bash(1) shells.

# To enable the settings / commands in this file for login shells as well,
# this file has to be sourced in /etc/profile.

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

use_color=true

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
        && type -P dircolors >/dev/null \
        && match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
        # Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
        if type -P dircolors >/dev/null ; then
                if [[ -f ~/.dir_colors ]] ; then
                        eval $(dircolors -b ~/.dir_colors)
                elif [[ -f /etc/DIR_COLORS ]] ; then
                        eval $(dircolors -b /etc/DIR_COLORS)
                fi
        fi

        if [[ ${EUID} == 0 ]] ; then
                PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[02;33m\] \w \$\[\033[00m\] '
        else
                PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
        fi


else
        if [[ ${EUID} == 0 ]] ; then
                # show root@ when we don't have colors
                PS1='\u@\h \W \$ '
        else
                PS1='\u@\h \w \$ '
        fi
fi

# Try to keep environment pollution down, EPA loves us.
unset use_color safe_term match_lhs

# Commented out, don't overwrite xterm -T "title" -n "icontitle" by default.
# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
#    ;;
#*)
#    ;;
#esac

# enable bash completion in interactive shells
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# sudo hint
#if [ ! -e $HOME/.sudo_as_admin_successful ]; then
#    case " $(groups) " in *\ admin\ *)
#    if [ -x /usr/bin/sudo ]; then
#	cat <<-EOF
#	To run a command as administrator (user "root"), use "sudo <command>".
#	See "man sudo_root" for details.

#	EOF
#    fi
#    esac
#fi

# if the command-not-found package is installed, use it
if [ -x /usr/lib/command-not-found ]; then
	function command_not_found_handle {
	        # check because c-n-f could've been removed in the meantime
                if [ -x /usr/lib/command-not-found ]; then
		   /usr/bin/python /usr/lib/command-not-found -- $1
                   return $?
		else
		   return 127
		fi
	}
fi

menu(){
    resposta=$(
      dialog --stdout               \
             --title 'BASHRC - MENU'  \
             --menu 'ESCOLHA UM SUB-PROGRAMA' \
            0 0 10                   \
            1 'CHECA PROGRAMAS' \
            2 'COPIA' \
            3 'MOVE' \
            4 'YOUTUBE MP3' \
            5 'YOUTUBE MP3 PLAYLIST' \
            6 'reserva' \
            7 'reserva' \
            8 'reserva' \


            0 'Sair'                )
    [ $? -ne 0 ] && break

    # De acordo com a opção escolhida, dispara programas
    case "$resposta" in
         1)
chk "aptitude"
chk "dialog"
chk "nautilus"
chk "gedit"
chk "geany"
chk "gimp"
chk "chromium-browser"
chk "evince"
chk "gnome-disk-utility"
chk "gparted"
chk "bleachbit"
chk "psensor"
chk "autotools-dev"
chk "pkg-config"
chk "intltool"
chk "dh-autoreconf"
chk "libgtk2.0-dev"
chk "libxfce4util-dev"
chk "libxfconf-0-dev"
chk "libxfce4ui-1-dev"
chk "libwnck-dev"
chk "wget"
chk "curl"
menu ;;
         2)
		ORIGEM=$(dialog --stdout --inputbox 'entre com ORIGEM' 0 0)
		DESTINO=$(dialog --stdout --inputbox 'entre com o DESTINO' 0 0)
		test $# -gt 0 && "$ORIGEM"
		test $# -gt 0 &&  "$DESTINO"
		copiar "$ORIGEM" "$DESTINO"
		menu ;;
         3)
		ORIGEM=$(dialog --stdout --inputbox 'entre com ORIGEM' 0 0)
		DESTINO=$(dialog --stdout --inputbox 'entre com o DESTINO' 0 0)
		test $# -gt 0 &&  "$ORIGEM"
		test $# -gt 0 &&  "$DESTINO"
		mover "$ORIGEM" "$DESTINO"
		menu ;;
         4) 	in=$(dialog --stdout --inputbox 'entre com link do youtube para converter video em mp3' 0 0)
		ytm "$1";;
         5) 	in=$(dialog --stdout --inputbox 'entre com link do youtube para converter playlist em mp3' 0 0)
		ytml "$1" ;;
         6) reserva ;;
         7) reserva ;;
         8) reserva ;;


         0) break ;;
    esac

}

