#!/bin/bash

dataTypes=$(awk 'NR==2' $1)
fieldNames=$(awk 'NR==3' $1)
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
			tmp=($(awk -v localInteger="$localInteger" -F: '{ if(NR > 3) print $1}' $1))
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
echo "$inputString" >> $1
