#!/bin/bash

#calling essential repeated function to check if directory is empty
source $myDirectory/essentials.sh

emptyFlag=5

checkEmptyDirectory $mySpace/$1

#List available tables in the directory if not empty

if [ $emptyFlag -eq 0 ]
then
titleString=" Existing Tables are: "
printInSquare $titleString ${#titleString}
tput setaf 4
tput bold
ls -1 $mySpace/$1
tput sgr0
echo "Choose a Table to display its content"
tput sc
read tableName
flag=1

#check if the name entered exists in the table list

while [ $flag -eq 1 ]
do
	if [ -f $mySpace/$1/$tableName ]
	then
	flag=0
	clear
	sed '1,2d' $mySpace/$1/$tableName | column -t -s ":"	
	#display useful table contents in column format

	else
	echo " '$tableName ' Table doesn't exist!"
	sleep 2
	tput rc
	tput ed
	tput sc
	read tableName
	fi
done
echo $'\nPress ENTER to continue'
read
fi
clear
