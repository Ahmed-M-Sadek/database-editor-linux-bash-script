#! /bin/bash

source $myDirectory/essentials.sh
emptyflag=5
checkEmptyDirectory $mySpace "databases"

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

echo "Currently you are working with ' $DBName ' database" $'\n'

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
	   sleep 1
	   source $myDirectory/createTable.sh $mySpace/$DBName
	   ;;
	2) echo "$choice ... "
	   sleep 1
	   source $myDirectory/deleteTable.sh $mySpace/$DBName
	   ;;
	3) echo "$choice ... "
	   sleep 1
	   source $myDirectory/insertData.sh $mySpace/$DBName
	   ;;
	4) echo "$choice ... "
	   sleep 1
	   source $myDirectory/ModifyData.sh $mySpace/$DBName
	   ;;
	5) echo "$choice ... "
	   sleep 1
	   source $myDirectory/displayTable.sh $DBName
	   ;;
	6) echo "$choice ... "
	   sleep 1
	   source $myDirectory/listTable.sh $DBName
	   ;;
	7) echo "$choice ... "
	   clear		
	   break;;
	*) echo "Insert a number from the previous choices"
esac
clear
REPLY=
echo "Currently you are working with ' $DBName ' database" $'\n'
COLUMNS=24
done

fi
