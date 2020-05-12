#!/bin/bash


#############################
ajuste1 () {
echo "Aguarde Ajustando nomes EM "$1" "
	cd $1 && rename 'y/A-Z/a-z/' *
	cd $1 && rename "s/-/_/g" *
	cd $1 && rename "s/ /_/g" *
	cd $1 && rename "s/__/_/g" *
	cd $1 && rename "s/..//g" * 
}
###############
ajuste1 $1
