#!/bin/bash

source $myDirectory/essentials.sh

emptyFlag=5
checkEmptyDirectory $1

if [ $emptyFlag -eq 0 ]
then
titleString=" Existing Tables are: "
printInSquare $titleString ${#titleString}
tput setaf 4
tput bold
ls -1 $1
tput sgr0
echo "Choose a Table to display its content"
tput sc
read tableName
flag=1

#check if the name entered exists in the table list

while [ $flag -eq 1 ]
do
        if [ -f $1/$tableName ]
        then
        flag=0
        clear
        else
        echo " '$tableName ' Table doesn't exist!"
        sleep 2
        tput rc
        tput ed
        tput sc
        read tableName
        fi
done
fi

dataTypes=$(awk 'NR==2' $1/$tableName)
fieldNames=$(awk 'NR==3' $1/$tableName)
inputString=""

IFS=':' read -r -a types <<<"$dataTypes"
IFS=':' read -r -a names <<<"$fieldNames"

for index in "${!types[@]}"
do
clear
	if [ $index -gt 0 ]
	then
		if [ "${types[index]}" = "n" ]
		then
			echo "Please enter an Integer for the field ${names[index]}"
			read localInteger
			while ! [[ "$localInteger" =~ ^-?[0-9]+$ ]]
			do
				clear
				echo "Please Enter an Integer value only"
				read localInteger
			done
			inputString+=":$localInteger"
			clear
		else
                echo "Please enter a string for the field ${names[index]}"
                read localString
		inputString+=":$localString"
                clear
		fi
	else
                if [ "${types[index]}" = "n" ]
                then
                        echo "Please enter an Integer for the Primary Key: ${names[index]}"
                        read localInteger
			tmp=($(awk -v localInteger="$localInteger" -F: '{ if(NR > 3) print $1}' $1/$tableName))
                        while ! [[ "$localInteger" =~ ^-?[0-9]+$ ]] || [[ "${tmp[@]}" =~ "${localInteger}" ]]
			do
				clear
                                echo "Please Enter a unique Integer value only"
                                read localInteger
			 done
			inputString+="$localInteger"

                else
                echo "Please enter a string for the field ${names[index]}"
                read localString
		inputString+="$localString"
                clear
                fi

	fi
done
echo "$inputString" >> $1/$tableName
