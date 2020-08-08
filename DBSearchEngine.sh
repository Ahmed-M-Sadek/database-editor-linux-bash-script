#!/bin/bash

# SHORTCUTS

# Working Space Shortcut

mySpace=$(awk -F: '{if(NR == 2){print $2}}' ./configFile.txt)

# Working Directory Shortcut

myDirectory=$(awk -F: '{if(NR == 1){print $2}}' ./configFile.txt)
# ====================================================================
# CREATE DEFAULT DIRECTORY

if [ ! -d "./Databases" ]
then
mkdir Databases
fi
# ====================================================================
# SET DEFAULT WORKING SPACE

echo "Do you want to use: $mySpace as your default space?"
echo "Y/N/Press any other key to exit"
read answer
clear

flag=1

if [[ $answer =~ ^[Y,y] ]]
then
echo "The current directory is: $mySpace"
cd $mySpace
sleep 2
clear
elif [[ $answer =~ ^[N,n] ]]
then
while [ $flag -eq 1 ]
do
	echo "Enter the new absolute directory: "
	read answer
	clear
	if [ -d $answer ]
	then
	flag=0
	awk -i inplace -F: -v var="$answer" '{if(NR==2){gsub($2,var)};{print $0}}' ./configFile.txt
	echo "Current Working Space is: $answer"
	cd $answer
	pwd
	sleep 2
	clear
	else
	echo "Wrong Directory !"
	sleep 1
	clear
	fi
done
else
clear
exit
fi
# ====================================================================
# USER INTERFACE

echo "Main Menu:"
IFS=""
choices=(
"Create new DB"
"Delete DB"
"Open DB"
"List existing DBs"
"Exit")

PS3='Enter your choice: '

select choice in  ${choices[@]}
do
case $REPLY in
	1) echo "$choice ... "
	   sleep 1
	   $myDirectory/create.sh $myDirectory
	   ;;
	2) echo "$choice ... "
	  ;;
	3) echo "$choice ... "
          ;;
	4) echo "$choice ... "
          ;;
	5) echo "$choice ... "
          ;;
	*) echo "Wrong choice, try again"
esac
REPLY=
done
