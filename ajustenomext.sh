#!/bin/bash


#############################
ajuste1 () {
	sudo find "$1" -type f -exec sudo mv -vu {} "$1" \;
	echo "Aguarde Ajustando nomes EM "$1" "
		cd $1 && rename 'y/A-Z/a-z/' * 1> /dev/null
		cd $1 && rename "s/.jpg//g" * 1> /dev/null
		cd $1 && rename "s/.jpeg//g" * 1> /dev/null
		cd $1 && rename "s/.gif//g" * 1> /dev/null
		cd $1 && rename "s/.png//g" * 1> /dev/null
		cd $1 && rename "s/Я//g" * 1> /dev/null
	done 
}
###############
