#! /bin/bash

source $myDirectory/essentials.sh

# check for empty directory
emptyFlag=5
checkEmptyDirectory $mySpace  "databases"

if [ $emptyFlag -eq 0 ]
then
myString=" Existing DBs are: "
printInSquare $myString ${#myString}
tput setaf 4
tput bold
ls -1 $mySpace
tput sgr0
echo "Kindly enter DB to be DELETED: "
tput sc
read deletedDB
flag=1
	while [ $flag -eq 1 ]
	do
		if [ -d $mySpace/$deletedDB ]
		then
		flag=0
		clear
		PS3='Kindly Enter your option: '
		echo "Are you sure you want to delete it?"
		select choice in Confirm Cancel 
		do
		case $REPLY in
			1) echo "$deletedDB deletion Confirmed ... "
			   rm -r $mySpace/$deletedDB
			   tput cup 10 20
			   echo "$name DB has been deleted Successfully"
			   sleep 1
			   clear
			   break;;
			2) echo "$REPLY ... "
			   clear
			   break;;
			*) echo "Wrong choice, try again"
			   sleep 1
			   clear
			   ;;
		esac
		REPLY=
		echo "Are you sure you want to delete it?"
		done
		else
		echo " ' $deletedDB ' DB doesn't exist!"
		sleep 2
		tput rc
		tput ed
		tput sc
		read deletedDB
		fi
	done
fi
