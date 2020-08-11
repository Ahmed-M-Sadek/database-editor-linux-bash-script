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
echo "Choose a Table to modify its content: "
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
        read tableName
        fi
done

# ==========================================================

tmp=($(awk -F: '{ if(NR > 3) print $1}' "$1/$tableName"))

echo "Kindly Enter your PK value: "
tput sc
read myPK

until [[ "${tmp[*]}" =~ (^|[[:space:]])"${myPK}"($|[[:space:]]) ]]
do
echo "This PK doesn't exist!" 
sleep 1
tput rc
tput ed
read myPK
done

# ===========================================================

source $myDirectory/modifyFns.sh

echo $'\n'
IFS=""
choices=(
"Delete the whole record containing this PK value?"
"Modify a specific cell in this record?"
"Back to previous menu")

PS3=$'\nKindly enter your option: '

select choice in  ${choices[@]}
do
case $REPLY in
	1) echo "$choice ... "
	   sleep 1
	   deleteRecord $myPK $1/$tableName
	   break;
	   ;;
	2) echo "$choice ... "
	   sleep 1
	   modifyCell $myPK $1/$tableName
	   ;;
	3) echo "$choice ... "
   	   clear		
   	   break;;
	*) echo "Wrong choice, try again"
	   sleep 1
	   clear
	   ;;
esac
clear
REPLY=
PS3=$'\nKindly enter your option: '
echo "You are working with PK = '$myPK'" $'\n'
done

# =============================================================

fi


