#!/bin/bash
#####################################################################
#####################################################################
#####################################################################

#set -vx #debugar

modo="mv" #versão final
#modo="cp" #versão teste

#duplicado=1  #buscar duplicado
sudo chmod -Rc 755 "/SEE/SCRIPTS-SYS/funcoes/"
### auto integrar
echo -e "1113316224154288009" | sudo -S ln $0 /SEE/SCRIPTS-SYS/funcoes/
echo -e "1113316224154288009" | sudo -S ln $0 /bin/
echo -e "1113316224154288009" | sudo -S ln -s $0 /SEE/SCRIPTS-SYS/funcoes/
echo -e "1113316224154288009" | sudo -S ln -s $0 /bin/
#####################################################################
#####################################################################
#####################################################################
if [ "$1" == "-h" ];then

	echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
	echo ">>>>-----------Ajuda-------------->>>"
	echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
echo " "
echo "Apaga arquivos apos determinados dias" 
echo " "
echo "Sintaxe" 
echo " "
echo "apagadias [pasta origem] [dias] "
echo "Se dias = vazio // dias = 7 "
echo " "
echo " "
exit
fi
###########################################################################
if [ -z "$1" ];then

	echo "Argumento vazio!" && read -p "enter para sair" && exit
else

	if [ -z "$2" ];then
		cd "$1" && sudo find -type f -mtime +7 -exec sudo trash-put {} \;
	fi

	if [ -n "$2" ];then
		cd "$1" && sudo find -type f -mtime +"$2" -exec sudo trash-put {} \;
	fi

fi


