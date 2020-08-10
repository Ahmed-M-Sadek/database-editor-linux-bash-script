#!/bin/bash

source $myDirectory/essentials.sh

emptyFlag=5
checkEmptyDirectory $1 "tables"

if [ $emptyFlag -eq 0 ]
then
myString=" Existing Tables are: "
printInSquare $myString ${#myString}
tput setaf 4
tput bold
ls -1 $1
tput sgr0
echo "Kindly enter the table to be DELETED: "
tput sc
read deletedTable
flag=1
	while [ $flag -eq 1 ]
	do
		if [ -f $1/$deletedTable ]
		then
		flag=0
		clear
		tmp="Confirm table deletion"
		PS3=$'\nKindly Enter your option: '
		echo "$tmp" $'\n'
		select choice in Confirm Cancel
		do
		case $REPLY in
			1) echo "$deletedTable deletion confirmed ..."
			   rm $1/$deletedTable
			   tput cup 10 20
			   echo "$deletedTable Table has been deleted successfully"
			   sleep 1
			   clear
			   break;;
			2) echo "$REPLY ..."
			   clear
			   break;;
			*) echo "Wrong choice, try again"
			   sleep 1
			   clear
			   ;;
		esac
		
		REPLY=
		echo "$tmp" $'\n'
		
		done
		else
		echo " '$deletedTable ' Table doesn't exist!"
		sleep 2
		tput rc
		tput ed
		tput sc
		read deletedTable
		fi
	done
fi
