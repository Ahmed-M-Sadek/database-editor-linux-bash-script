#!/bin/bash

# =================================================
# CREATE NEW DATABASE DIRECTORY

echo "Creating a new Database"
flag = 1

while [ $flag -eq 1 ]
do
	echo "Enter a name for the new database"
	echo "C/c to cancel"
	read dbname

	if [ -d ./$dbname ]
	then
	echo "Database name already exists"

	elif [[ "$dbname" =~ [C,c] ]]
	then
	break

	else
	mkdir $dbname
	flag = 0
	fi

	sleep 2
	clear
done

# ==================================================
# CALL OPEN DATABASE SCRIPT

