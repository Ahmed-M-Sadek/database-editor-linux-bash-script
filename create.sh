#!/usr/bin/bash

echo "Creating a new database"
echo "Please enter a name for the database"
read dbname
if [ ! -d "./Databases" ]
then
	echo "directory does not exist"
	mkdir Databases
fi
cd ./Databases
touch  $dbname
echo "enter field names ('exit' to save)"
read localinput
while [ -z "$localinput" ] || [ "$localinput" == "exit" ]
do
echo "at least one field should be specified"
read localinput
done
echo -n $localinput >> $dbname
read localinput
while [ "$localinput" != "exit" ]
do
if [ -n "$localinput" ]
then
echo -n ":$localinput" >> $dbname
else
echo "field name can not be empty"
fi
read localinput
done
echo >> $dbname
