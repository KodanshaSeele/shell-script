  #!/bin/bash 
#-x
	
###############################################################
permissao () {	
	sudo chmod -c 755 "$1"
	case "$?" in
	0) echo "$1 - permissao --ok" > /dev/null 2>&1 
	;;
	1) echo "$1 - permissao --erro" 
	exit
	;;
	 esac 
}

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

chkprog () {
	dpkg -l | grep "$1" 2>&1 >/dev/null
	[ $? == "1" ] && echo "Instalando $1" && sudo apt install $1 -y
	[ $? == "0" ] && echo "O programa $1 está instalado " 
}

sudo blockdev --setrw /dev/sdb #corrigindo erro pendriver

##########################
chkprog "dialog"
chkprog "findimagedupes"
chkprog "fdupes"
chkprog "nomacs" 
chkprog "trash-cli" 
##########################

EXTENSOES () {
 
	
##########################
entrada="/home/anderson/.neosys/entrada"
chkpst "$entrada"
for EXT in   "jpg" "png" "pdf" "jpeg" "mkv" "mp4" "mp3" "gif" "rm" "flv" "3gp" "avi" "mov" "wmv" "m4a" "m4v" "ogg" "aac" "flac" "webp" "ps" "aiml"  "pp." "ot." "sh" "eps" "pls" "fod." "doc." "dbf" "mid" "ino" "smc" "tex" "bz2" "xl." "od." "xcf" "jar" "zip" "sv." "bin" "fz." "autosave" "3ga" "7z" "aac" "ai" "cdr" "dif" "dot" "kdenlive" "m3u" "mml" "oog" "sla" "slk" "uop" "pot." "ptt." "vcf" "pl" "cgi" "apk" "ttf" "gif" "csv" "iso" "deb" "xspf" "srt" "mkv" "mp4" "m4v" "mov" "avi" "flv" "mpg" "wmv";
do


##########################
		filelist=$(mktemp /tmp/XXXXXXXXXX)
		filelist2=$(mktemp /tmp/XXXXXXXXXX)
			[ ! -f "$filelist" ] && echo "erro no filelist1 arquivos" && exit 
			[ ! -f "$filelist2" ] && echo "erro no filelist2 arquivos" && exit 
		sudo find "$1" -type f -iname "*$EXT" >> "$filelist" 
     	cat "$filelist" | grep -i "$EXT$" >> "$filelist2" 
					
	############################# sudo find "$a9" -type f | egrep -i "png$"
			while read linha
			do
			chkpst ""$2"/.neosys/1/doc/$EXT$/"
			chkpst "$entrada/$EXT$/"
		[ -f "$linha" ] && echo "origem "$1" - destino "$2""
		[ -f "$linha" ] && echo "buscando $EXT em "$1""
		[ -f "$linha" ] && mover "$linha" ""$2"/.neosys/1/doc/$EXT$/" 
		[ -f "$linha" ] && mover "$linha" "$entrada/$EXT$/" 
			done < $filelist2
done
	}
	
VIDEOS () {
filevideos=$(mktemp /tmp/XXXXXXXXXX)
filevideos2=$(mktemp /tmp/XXXXXXXXXX)
chkpst ""$2"/.neosys/1/filmes"
chkpst ""$2"/.neosys/entrada"
##########################
	[ -d "$1" ] && sudo find ""$2"/.neosys/1/doc" -type f -size +70M >> "$filevideos"
	[ -d "$1" ] && sudo find "$1" -type f -iname "*.srt" >> "$filevideos"
	##########################
	for videos in  "mkv" "mp4" "m4v" "mov" "avi" "flv" "mpg" "wmv" "srt" ; 
	do
		cat $filevideos | grep -i "$videos$" >> "$filevideos2"
		########################## 
		while read linha
		do
		[ -f "$linha" ] && echo "origem "$1" - destino "$2""
		[ -f "$linha" ] && mover "$linha" ""$2"/.neosys/1/filmes" 
		[ -f "$linha" ] && mover "$linha" ""$2"/.neosys/entrada"
		done < $filevideos2
		##########################
	done				
##########################  
}
#######################################################################
				case "$1" in

					 -h)
					 echo "
#######################################################################
#######################################################################
#######################################################################
#######################################################################
	sintaxe
	$0 [origem] [destino]
	ou
	$0 [origem] (destino automatico)					 
	ou
	$0 (origem  e destino automatico)					 
#######################################################################
#######################################################################
#######################################################################
#######################################################################
" 
					 ;;
					 
					 *) 
 [ ! -z "$1" ]
    case "$?" in
         0) echo "Origem existe "$1"" 
			 [ ! -z "$2" ]
				case "$?" in
					 0) echo "destino existe "$2"" 
					 	VIDEOS "$1" "$2"
						EXTENSOES "$1" "$2"
					 ;;
					 1) echo "destino nao existe "$2"" 
					 					 read -p "mover arquivos para $HOME/.neosys/1/doc  ? 
					 enter para continuar"
						VIDEOS "$1" "$HOME"
						EXTENSOES "$1" "$HOME"
					 ;;
					 *) echo "erro desconhecido no segundo argumento - $?" ;;
				esac         
         ;;
         1) clear && echo "Origem nao existe  "$1"" 
         					 					 read -p "varrer pastas usuario  ? 
					 enter para continuar"
			for IN in  "$HOME/Imagens" "$HOME/Desktop" "$HOME/Documentos" "$HOME/Downloads" "$HOME/Modelos" "$HOME/Música" "$HOME/Público" "$HOME/Vídeos" ;
			do

								[ -d "$IN" ] && VIDEOS "$IN" "$HOME"
								[ -d "$IN" ] && EXTENSOES "$IN" "$HOME"     
			done
         ;;
         *) echo "erro desconhecido no primeiro argumento - $?" ;;
    esac
    
exit
					 
					  ;;
				esac  
