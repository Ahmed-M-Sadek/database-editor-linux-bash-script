#! /bin/bash

source $myDirectory/essentials.sh

# check for empty directory
emptyFlag=5
checkEmptyDirectory $mySpace 

if [ $emptyFlag -eq 0 ]
then
myString=" Existing DBs are: "
printInSquare $myString ${#myString}
tput setaf 4
tput bold
ls -1 $mySpace
tput sgr0
echo "Press any key to go back"
read
clear
fi
