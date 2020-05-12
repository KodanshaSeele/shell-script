#!/bin/bash -x
###############
# AUTO INTEGRAR
###############
nomescript="imgorg"
pasta="/home/.neosys/1/doc/script"
externo="/media/anderson/bddea36a-25e8-4eb3-988e-a503ac1dc3d1/.neosys"
sudo cp -vb $0 "/bin/$nomescript"
[ ! -d "$pasta" ] && sudo mkdir -p "$pasta"
sudo cp -vb $0 "/home/.neosys/1/doc/script/$nomescript"
#######################################################
apagavazio () {
sudo find "$externo" -empty -exec sudo trash {} \;
}
###########################
	for IN in "/home/.neosys/1/entrada" "/home/.neosys/1/doc/img" ;
	do
	[ ! -d "$IN" ] && sudo mkdir -p "$IN"
	done
###########################
restaurar () {
	############################# 
	for IN in "$externo" "/home/.neosys/1/entrada" "/home/seele/Imagens" "/home/seele/Desktop" "/home/seele/Documentos" "/home/seele/Downloads" "/home/seele/Modelos" "/home/seele/Música" "/home/seele/Público" "/home/seele/Vídeos" ;
	do
	echo " triagem files - $IN - $EXT"
	[ -d "$IN" ] && sudo find "$IN" -size "-30k" -iname "*.png" -exec sudo trash {} \; 
	[ -d "$IN" ] && sudo find "$IN" -size "-30k" -iname "*.jpg" -exec sudo trash {} \; 
	clear

############################# 
###########################

			destino="/home/seele/Documentos"
			origem="$externo"
			apagavazio "$origem"

	#############################
	for I in "png" "jpg" "jpeg" ;
	do
	#############################
		stop="15"
		tipo="$I"
#		pasta="/home/.neosys/1/doc/img/$tipo/"$stop""
#		[ ! -d "$pasta" ] && sudo mkdir -p "$pasta"
#		[ -d "$pasta" ] && 
sudo find "$origem" -size "-$stop"k -iname "*."$tipo"" -exec sudo trash {} \; 
	#############################
	done
	#############################
	for I in "png" "jp*" ;
	do
			
		#	origem="/home/seele/.local/share/Trash/files"
	#############################
		start="15"
		stop="30"
		tipo="$I"
		pasta="/home/.neosys/1/doc/img/$tipo/"$stop""
		[ ! -d "$pasta" ] && sudo mkdir -p "$pasta"
		[ -d "$pasta" ] && sudo find "$origem" -size "+$start"k -size "-$stop"k -iname "*."$tipo"" -exec sudo mv -vu {} "$pasta" \; 
	#############################
		start="30"
		stop="60"
		tipo="$I"
		pasta="/home/.neosys/1/doc/img/$tipo/"$stop""
		[ ! -d "$pasta" ] && sudo mkdir -p "$pasta"
		[ -d "$pasta" ] && sudo find "$origem" -size "+$start"k -size "-$stop"k -iname "*."$tipo"" -exec sudo mv -vu {} "$pasta" \; 
	#############################
		start="60"
		stop="120"
		tipo="$I"
		pasta="/home/.neosys/1/doc/img/$tipo/"$stop""
		[ ! -d "$pasta" ] && sudo mkdir -p "$pasta"
		[ -d "$pasta" ] && sudo find "$origem" -size "+$start"k -size "-$stop"k -iname "*."$tipo"" -exec sudo mv -vu {} "$pasta" \; 
	#############################
		start="120"
		stop="300"
		tipo="$I"
		pasta="/home/.neosys/1/doc/img/$tipo/"$stop""
		[ ! -d "$pasta" ] && sudo mkdir -p "$pasta"
		[ -d "$pasta" ] && sudo find "$origem" -size "+$start"k -size "-$stop"k -iname "*."$tipo"" -exec sudo mv -vu {} "$pasta" \; 
	#############################
		start="300"
		stop="600"
		tipo="$I"
		pasta="/home/.neosys/1/doc/img/$tipo/"$stop""
		[ ! -d "$pasta" ] && sudo mkdir -p "$pasta"
		[ -d "$pasta" ] && sudo find "$origem" -size "+$start"k -size "-$stop"k -iname "*."$tipo"" -exec sudo mv -vu {} "$pasta" \; 
	#############################
		start="600"
		stop="1200"
		tipo="$I"
		pasta="/home/.neosys/1/doc/img/$tipo/"$stop""
		[ ! -d "$pasta" ] && sudo mkdir -p "$pasta"
		[ -d "$pasta" ] && sudo find "$origem" -size "+$start"k -size "-$stop"k -iname "*."$tipo"" -exec sudo mv -vu {} "$pasta" \; 
	#############################
			apagavazio "$pasta"
	done
	#############################
	done

}
############################# 

#	excluir

	restaurar


