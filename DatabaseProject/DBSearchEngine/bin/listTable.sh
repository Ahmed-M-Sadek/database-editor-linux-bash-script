#! /bin/bash

source $myDirectory/essentials.sh

emptyFlag=5
checkEmptyDirectory $mySpace/$1 "tables"

if [ $emptyFlag -eq 0 ]
then
titleString=" Existing Tables are: "
printInSquare $titleString ${#titleString}
tput setaf 4
tput bold
ls -1 $mySpace/$1
tput sgr0
echo "Press ENTER to return"
read
clear
fi
