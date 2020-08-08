#!/bin/bash

echo "Currently working with $1"

IFS="|"

choices=(
"Create new Table"
"Delete Table"
"Insert into Table"
"Modify a Table"
"Display a table"
"List existing Tables"
"Back to main menu")

PS3='Enter your choice: '

select choice in ${choices[@]}
do
case $REPLY in
	1) echo "$choice ... "
	  break;;
	2) echo "$choice ... "
	  break;;
	3) echo "$choice ... "
	  break;;
	4) echo "$choice ... "
	  break;;
	5) echo "$choice ... "
	  break;;
	6) echo "$choice ... "
	  break;;
	7) exit
	  break;;
	*) echo "insert a number from the previous choices"
esac
done
