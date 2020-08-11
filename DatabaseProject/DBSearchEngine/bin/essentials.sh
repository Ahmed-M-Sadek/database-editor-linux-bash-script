#! bin/bash

# to use this file, you will need to source it

# =================================================================

# A function to check whether the directory is empty or not
# Make a variable "emptyFlag" outside the function's scope
# You will need to pass the absolute directory

checkEmptyDirectory() {
emptyFlag=1
if [ -z "$(ls -A "$1")" ]
then
echo "You don't have any $2 yet"
sleep 2
clear
else
emptyFlag=0
fi
}

# =================================================================

# A function to print strings in a square
# you will need to pass the required string to the function 
# as a first parameter and its length as a second parameter

printInSquare() {
echo "+$(yes = | head -$2 | tr -d "\n")+"
echo "|$1|"
echo "+$(yes = | head -$2 | tr -d "\n")+"
}
