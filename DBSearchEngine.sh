#!/bin/bash

clear

cd $(dirname $(realpath $0))

# ===================================================================
# ===================================================================
# SHORTCUTS

# Working Space Shortcut
mySpace=$(awk -F: '{if(NR == 2){print $2}}' ./configFile.txt)

# ====================================================================
# GET WORKING DIRECTORY AND SET DEFAULT WORKING SPACE
awk -i inplace -F: -v var="$(pwd)/bin" '{if(NR==1){gsub($2,var)};{print $0}}' ./configFile.txt

# Working Directory Shortcut
myDirectory=$(awk -F: '{if(NR == 1){print $2}}' ./configFile.txt)

# CREATE DEFAULT DIRECTORY

if [ ! -d "./Databases" ]
then
mkdir Databases
fi

if [ ! -d $mySpace ]
	then
	awk -i inplace -F: -v var="$(pwd)/Databases" '{if(NR==2){gsub($2,var)};{print $0}}' ./configFile.txt
fi

# ===================================================================
# RELOAD SHORTCUTS

# Working Space Shortcut

mySpace=$(awk -F: '{if(NR == 2){print $2}}' ./configFile.txt)

# ====================================================================
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

# ===================================================================
# RELOAD SHORTCUTS
# Working Space Shortcut

mySpace=$(awk -F: '{if(NR == 2){print $2}}' $myDirectory/../configFile.txt)

# ====================================================================
# ====================================================================
# USER INTERFACE

echo $'Main Menu:\n'
IFS=""
COLUMNS=18
choices=(
"Create new DB"
"Delete DB"
"Open DB"
"List existing DBs"
"Exit")

PS3=$'\nEnter your choice: '

select choice in  ${choices[@]}
do
case $REPLY in
	1) echo "$choice ... "
	   sleep 1
	   $myDirectory/create.sh $myDirectory
	   ;;
	2) echo "$choice ... "
	   source $myDirectory/delete.sh
	   ;;
	3) echo "$choice ... "
	   source $myDirectory/open.sh
           ;;
	4) echo "$choice ... "
	   source $myDirectory/list.sh
           ;;
	5) echo "$choice ... "
	   clear
	   tput cup 10 20;
	   echo " Au Revoir :'( "
	   sleep 3
	   clear
	   break 
           ;;
	*) echo "Wrong choice, try again"
	   clear
	   ;;
esac
REPLY=
PS3=$'\nEnter your choice: '
echo $'Main Menu:\n'
COLUMNS=18
done
