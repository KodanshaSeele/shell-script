#!/bin/bash -x
###########################
systemback () {
programa="aptitude"
while true; do
	which "$programa" | grep "$programa"
	case "$?" in
        0)
		echo ""$programa" já está Instalando"
		break
            ;;
         
        1)
 	sudo apt-get install "$programa"
            ;;
         
        *)
            echo "ERRO INESPERADO! "

	esac
done	
}
systemback

