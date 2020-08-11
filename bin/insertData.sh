#!/bin/bash

source $myDirectory/essentials.sh

emptyFlag=5
checkEmptyDirectory $1 "tables"

if [ $emptyFlag -eq 0 ]
then
titleString=" Existing Tables are: "
printInSquare $titleString ${#titleString}
tput setaf 4
tput bold
ls -1 $1
tput sgr0
echo "Kindly enter a Table name to insert into:"
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

echo "Now you are going to insert into ' $tableName ' Table" $'\n'

dataTypes=$(awk 'NR==2' $1/$tableName)
fieldNames=$(awk 'NR==3' $1/$tableName)
inputString=""

IFS=':' read -r -a types <<<"$dataTypes"
IFS=':' read -r -a names <<<"$fieldNames"

for index in "${!types[@]}"
do
tput cup 2 0
tput ed
	if [ $index -gt 0 ]
	then
		if [ "${types[index]}" = "n" ]
		then
			echo "Please enter an Integer for the field ${names[index]}"
			read localInteger
				while ! [[ "$localInteger" =~ ^-?[0-9]+$ ]]
				do
					tput cup 2 0
					tput ed
					echo "Please Enter an Integer value only"
					read localInteger
				done
			inputString+=":$localInteger"
			tput cup 2 0
			tput ed
		else
                echo "Please enter a string for the field ${names[index]}"
                tput sc
		read localString
			until [[ $localString =~ ^[A-Za-z] ]]
			do
			echo "Please enter a string!"
			tput rc
			tput ed 
			read localString
			done
		inputString+=":$localString"
		tput cup 2 0
		tput ed
		fi
	else
		tmp=$(awk -F: '{if(NR > 3) print $1}' "$1/$tableName")
                if [ "${types[index]}" = "n" ]
                then
                        echo "Please enter an Integer for the Primary Key: ${names[index]}"
                        tput sc
                        read localInteger
			 
			 great=1
                        until [ $great -eq 0 ] 
			 do
			        if ! [[ "$localInteger" =~ ^-?[0-9]+$ ]]
				then
                               echo "Please Enter an Integer value ! "
                               great=1
                               else
                               great=0
                               fi
                               
                               if [[ "${tmp[*]}" =~ (^|[[:space:]])"${localInteger}"($|[[:space:]]) ]]
                               then
                               echo "The P.K. value needs to be unique!"
                               great=1
                               else
                               great=$((($great)|0))
                               fi
                               
                               if [ $great -eq 1 ]
		               then
		               sleep 1
				tput rc
				tput ed 
				read localInteger
				fi
                               
			 done
			inputString+="$localInteger"

                else
                echo "Please enter a string for the field ${names[index]}"
                tput sc
		read localString
			great=1
			until [ $great -eq 0 ] 
			do
			if ! [[ $localString =~ ^[A-Za-z] ]]
			then
			echo "Please enter a string!"
			great=1
			else
			great=0
			fi
			
			if [[ "${tmp[*]}" =~ (^|[[:space:]])"${localString}"($|[[:space:]]) ]]
                       then
                       echo "The P.K. value needs to be unique!"
                       great=1
                       else
                       great=$((($great)|0))
                       fi
                       
                       if [ $great -eq 1 ]
                       then
                       sleep 1
			tput rc
			tput ed 
			read localString
			fi
			
			done
		inputString+="$localString"
		tput cup 2 0
		tput ed
		fi

	fi
done
echo "$inputString" >> $1/$tableName
clear
fi
