#! /bin/bash

source $myDirectory/essentials.sh

# check for empty directory
emptyFlag=5
checkEmptyDirectory $mySpace "databases"

if [ $emptyFlag -eq 0 ]
then
myString=" Existing DBs are: "
printInSquare $myString ${#myString}
tput setaf 4
tput bold
ls -1 $mySpace
tput sgr0
echo "Press ENTER to go back"
read
clear
fi
