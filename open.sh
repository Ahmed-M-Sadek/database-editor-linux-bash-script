#! /bin/bash

source $myDirectory/essentials.sh
emptyflag=5
checkEmptyDirectory $mySpace

if [ $emptyFlag -eq 0 ]
then

myString=" Existing DBs are: "
printInSquare $myString ${#myString}
tput setaf 4
tput bold
ls -1 $mySpace
tput sgr0

echo "Kindly enter DB to open: "
tput sc
read DBName

until [ -d "$DBName" ]
do
echo "$DBName doesn't exist!"
sleep 1
tput rc
tput ed
tput sc 
read DBName
done

clear

echo "Currently working with $DBName" $'\n'

IFS=""
COLUMNS=24

choices=(
"Create new Table"
"Delete Table"
"Insert into Table"
"Modify a Table"
"Display a table"
"List existing Tables"
"Back to main menu")

PS3=$'\nEnter your choice: '

select choice in ${choices[@]}
do
case $REPLY in
	1) echo "$choice ... "
	   source $myDirectory/createTable.sh $DBName
	   ;;
	2) echo "$choice ... "
	   source $myDirectory/deleteTable.sh $DBName
	   ;;
	3) echo "$choice ... "
	   ;;
	4) echo "$choice ... "
	   ;;
	5) echo "$choice ... "
	   source $myDirectory/displayTable.sh $DBName
	   ;;
	6) echo "$choice ... "
	   source $myDirectory/listTable.sh $DBName
	   ;;
	7) echo "$choice ... "
	   ;;
	*) echo "Insert a number from the previous choices"
	   clear
	   sleep 1
	   ;;
esac
REPLY=
echo "Currently working with $1" $'\n'
COLUMNS=24
done

fi
