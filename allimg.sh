#!/bin/bash 

####################
apagadup () {
sudo fdupes -NrdH "$1" 
}
##########################
tratanome () {
cd $1 && for i in *
do 
rename "s/.jpeg//gi" "$i" #1> /dev/null
done
##########################
cd $1 && for i in *
do 
rename "s/.jpg//gi" "$i" #1> /dev/null
done
##########################
cd $1 && for i in *
do 
rename "s/.png//gi" "$i" #1> /dev/null
done
##########################
cd $1 && for i in *
do 
rename "s/.gif//gi" "$i" #1> /dev/null
done
##########################
cd $1 && for i in *
do 
rename "s/Я//gi" "$i" #1> /dev/null
done
##########################
cd $1 && for i in *
do 
rename "y/ /_/" "$i" #1> /dev/null
done
##########################
cd $1 && for i in *
do 
rename "s/__/_/gi" "$i" #1> /dev/null
done
##########################
cd $1 && for i in *
do 
rename "s/___/_/gi" "$i" #1> /dev/null
done
##########################
cd $1 && for i in *
do 
	id=$(identify $i)
		res=$( echo $id | cut -d ' ' -f"3" )
		rename "s/$res//g" "$i"
			ext=$( echo $id | cut -d ' ' -f"2" )


	mv -vu "$i" "$res"Я"$i"."$ext"
done
##########################
cd $1 && for i in *
do 
rename "y/A-Z/a-z/" "$i" #1> /dev/null
done
##########################
}
##########################
compactajpg() { 
nome="/tmp/converter.txt"
sudo rm -f $nome
touch $nome
        [ -d "$1" ] && find "$1" -iname "*.png" >> "$nome"
        [ -d "$1" ] && find "$1" -iname "*.jpeg" >> "$nome"
	while read linha
	do
	echo $linha
	convert "$linha" "${linha%.*}.jpg"
	echo "convert - $?"
	trash-put "$linha"
	echo "trash-put - $?"
	done < $nome
}
##########################
redimensionajpg() {
resizejpg() { 
mogrify -path $3 -filter Triangle -define filter:support=2.0 -unsharp 0.25x0.25+8.00+0.065 -dither None -posterize 136 -background Black -alpha Background -quality $2 -define jpeg:fancy-upsampling=off -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=1 -define png:exclude-chunk=all -colorspace YCbCr $1

#convert -interlace Plane -define jpeg:dct-method=float "$1" "$1"

#convert "$1" -filter Lanczos -colorspace sRGB "$1"
}
#############
##########################
	jpgrenamed=$(mktemp /tmp/XXXXXXXXXX)
	fileimjpg2=$(mktemp /tmp/XXXXXXXXXX)
	sudo find "$1" -type f >> $jpgrenamed
	cat $jpgrenamed | grep -i ".jpg" >> $fileimjpg2
##########################
		##########################
		while read linha
		do
		echo "convertedo "$linha""
		resizejpg "$linha" 85 "$1"
		done < $fileimjpg2
		##########################
cd $1 && for i in *
do 
rename "s/Ж//gi" "$i" #1> /dev/null
done
##########################
cd $1 && for i in *
do 
	mv -vu "$i" ""Ж"$i"

done
}
##########################
#############################
dupes() { 
dupes=$(mktemp /tmp/XXXXXXXXXX)
echo "fdupes em "$1""
findimagedupes -t 95% "$1" > "$dupes"
repetido1=$(mktemp /tmp/XXXXXXXXXX)
repetido2=$(mktemp /tmp/XXXXXXXXXX)
	while read linha
	do
	echo "$linha" | cut -d ' ' -f"2" >> "$repetido1"
	echo "$linha" | cut -d ' ' -f"3" >> "$repetido1"
	echo "$linha" | cut -d ' ' -f"4" >> "$repetido1"
	echo "$linha" | cut -d ' ' -f"5" >> "$repetido1"
	echo "$linha" | cut -d ' ' -f"6" >> "$repetido1"
	echo "$linha" | cut -d ' ' -f"8" >> "$repetido1"
	echo "$linha" | cut -d ' ' -f"9" >> "$repetido1"
	echo "$linha" | cut -d ' ' -f"10" >> "$repetido1"
	echo "$linha" | cut -d ' ' -f"11" >> "$repetido1"
	done < "$dupes"
##########
	sed '/^$/d' "$repetido1" > "$repetido2" #apaga linhas em branco
##########
	while read linha
	do
        sudo trash-put "$linha"
	done < "$repetido2"
echo "fim fdupes"
}
##########################

resolution() { 

#destino="/SEE/back/1/albuns/resolition"
destino="/home/anderson/Imagens/teste"

CONTADOR=100
while [  $CONTADOR -lt 6000 ]; do
      echo "$CONTADOR";

	pastares="$destino/$CONTADOR"
	echo "buscando duplicados em "$pastares" "$1"" 
	[ ! "$pastares" = "$1" ] && fdupes -Nrd "$pastares" "$1"
	[ "$pastares" = "$1" ] && fdupes -Nrd "$pastares" 
	sudo mkdir -p "$pastares"
	sudo chmod -Rc 777 "$pastares"
	[ ! -d "$pastares" ] && echo "a pasta "$pastares" não foi criada!" && exit

      let CONTADOR=CONTADOR+100; 
done
#####
#####
nome=$(mktemp /tmp/XXXXXXXXXX)
        [ -d "$1" ] && find "$1" -iname "*.jpg" >> "$nome"
        [ -d "$1" ] && find "$1" -iname "*.jpeg" >> "$nome"
##############################################################################
XD=0
		while read linha
		do
		res=$(identify $linha | cut -d ' ' -f"3" | cut -d 'x' -f"1")
		echo "resolução - $res"
		CONTADOR=100
			while [  $CONTADOR -lt 6000 ]; do
			echo "$CONTADOR";
				pastares="$destino/"$CONTADOR""
				echo "destino em $pastares - "$res" - "$CONTADOR""
				[ "$res" -lt "$CONTADOR" ] && sudo mv -vu $linha "$pastares" && echo "status $?" && break
				echo "atual! $res - "$CONTADOR"" 						 
			      let CONTADOR=CONTADOR+100; 
			done
#clear
echo "Contando! - $XD"
let XD=XD+1; 	
		done < $nome
}
##########################

apagadup "$1"
read -p "enter"
tratanome "$1"
read -p "enter"
compactajpg "$1"
read -p "enter"
redimensionajpg "$1"
read -p "enter"
dupes "$1"
read -p "enter"
resolution "$1" 
 





exit


