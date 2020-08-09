#!/bin/bash

#sub menu choices

choices=(
"Integer"
"String")

#===================================================
# Creating Table file

clear
echo "Enter a name for the new table"
read tableName
sleep 0.5
clear

touch $tableName

#===================================================
# Checking number of table columns

echo "Enter the number of columns"
read cnumber

while [[ $cnumber =~ '!(^[0-9]+)' || $cnumber -lt 1 ]]
do
	echo "PLease enter a number of columns"
	read cnumber
done
echo $cnumber > $tableName

#===================================================
# Adding Primary key value and datatype

echo "Enter the primary key for the database"
read localPK
select choice in ${choices[@]}
do
case $REPLY in
        1) localtype="n"
          break;;
        2) localtype="s"
          break;;
	*) echo "Wrong choice"
esac
done

echo -n "$localtype" >> $tableName
fields+="$localPK"

#===================================================
# Adding the rest of the columns

for (( i=2; i<=$cnumber; i++ ))
do
	echo "Enter field name"
	read localName
	echo "Enter field type for column $localName:"
	select choice in ${choices[@]}
	do
	case $REPLY in
		1) localtype="n"
		  break;;
		2) localtype="s"
		  break;;
		*) echo "Wrong choice, choose again"
	esac
	done

	echo -n ":$localtype" >> $tableName
	fields+=":$localName"
done

echo >> $tableName
echo $fields >> $tableName

