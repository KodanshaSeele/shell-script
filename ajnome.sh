#!/bin/bash
if [ "$@" == "-h" ];then

	echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
	echo ">>>>-----------Ajuda-------------->>>"
	echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
echo " "
echo "Ajusta automaticamente os nomes de arquivos" 
echo "da pasta especificada. "
echo " "
echo "Sintaxe" 
echo " "
echo "ajnome [pasta]"
echo " "
echo " "
echo " "
exit
fi
###########################################################################

[ -z "$1" ] && echo "Argumento [pasta] está vazio!" && exit 
###########################################################################
rm -rf /tmp/qtdfilesajnome.txt
find "$1" -type f >> /tmp/qtdfilesajnome.txt
#RETORNA APENAS O NUMERO DE LINHAS
qtd=`(wc -l /tmp/qtdfilesajnome.txt | cut -d" " -f 1)`
A="$qtd"
B="$qtd"
###########################################################################

	echo "Ajustando nomes em $1"
###############
#cd "$1" && rename "s/.jpeg_[0-9]$\|.jpeg[0-9]$\|.jpeg.tmp_[0-9]$/.jpg/g" *
#cd "$1" && rename "s/.jpeg_[0-9][0-9]$\|.jpeg[0-9][0-9]$\|.jpeg.tmp_[0-9][0-9]$/.jpg/g" *
#cd "$1" && rename "s/.jpg_[0-9]$\|.jpg[0-9]$\|.jpg.tmp_[0-9]$/.jpg/g" *
#cd "$1" && rename "s/.jpg_[0-9][0-9]$\|.jpg[0-9][0-9]$\|.jpg.tmp_[0-9][0-9]$/.jpg/g" *

#cd "$1" && rename "s/[//" * 
#cd "$1" && rename "s/]//" * 

#cd "$1" && rename 's, ,_,g' *

##############################

##############################
#retira acentos


clear
echo "Aguarde Ajustando nomes EM `(pwd)` "
cd "$1" && rename "s/[0-9]ª//g" "*" 
cd "$1" && rename "s/[()]//g" "*" 
cd "$1" && rename "s/^_//" "*"
cd "$1" && rename 's,-,_,g' "*"
cd "$1" && rename 's, ,_,g' "*"
cd "$1" && rename 's,~$,,g' "*"
cd "$1" && rename 's,__,_,g' "*"
cd "$1" && rename 's,___,_,g' "*"
cd "$1" && rename 's, ,_,g' "*"
cd "$1" && rename "s/copia//g" "*" 
cd "$1" && rename 'y/A-Z/a-z/' "*"

#fdupes -Nrd $1 #apaga duplicados

#cd "$1" && for file in *;
#do
#clear
#A=$((A-1))
#echo "Aguarde Ajustando nomes EM `(pwd)` - $A"
#convmv -f iso-8859-1 -t utf-8 --notest "$file"
#newname=`echo "$file" | iconv -t 'ascii//TRANSLIT'`
#[ -f "$newname" ] && echo "$newname já existe!!"
#[ ! -f "$newname" ] && mv "$file" "$newname"
#done


##############################

###############



