#!/bin/bash

#sub menu choices

choices=(
"Integer"
"String")

#===================================================
# Creating Table file


clear
echo "Enter a name for the new table: "
tput sc
read tableName
sleep 0.5


until [ ! -f $1/$tableName ]
do

	echo "Table already exists!"
	sleep 1
	tput rc
	tput ed
	read tableName

done

touch $1/$tableName

clear

echo "Now you are working with ' $tableName ' table." $'\n'

#===================================================
# Checking number of table columns

echo "Enter the number of columns"
read cnumber

while [[ $cnumber =~ '!(^[0-9]+)' || $cnumber -lt 2 ]]
do
	tput cup 2 0
	tput ed
	echo "PLease enter the number of columns"
	read cnumber
done
echo $cnumber > $1/$tableName

sleep 0.5
tput cup 2 0
tput ed
#===================================================
# Adding Primary key value and datatype

echo "Enter the primary key for the database"
read localPK
echo $'\n' "Enter field type for column $localPK:" 
select choice in ${choices[@]}
do
case $REPLY in
        1) localtype="n"
          break;;
        2) localtype="s"
          break;;
	*) echo "Wrong choice"
esac
REPLY=
echo $'\n' "Enter field type for column $localPK:"
done

echo -n "$localtype" >> $1/$tableName
fields+="$localPK"

sleep 0.5
tput cup 2 0
tput ed
#===================================================
# Adding the rest of the columns

for (( i=2; i<=$cnumber; i++ ))
do
	echo "Enter field name for column $i:"
	read localName
	echo $'\n' "Enter field type for column $localName:" 
	select choice in ${choices[@]}
	do
	case $REPLY in
		1) localtype="n"
		  break;;
		2) localtype="s"
		  break;;
		*) echo "Wrong choice, choose again"
	esac
	REPLY=
	echo $'\n' "Enter field type for column $localName:"
	done

	echo -n ":$localtype" >> $1/$tableName
	fields+=":$localName"

sleep 0.5
tput cup 2 0
tput ed
done

echo >> $1/$tableName
echo $fields >> $1/$tableName

tput cup 10 20
echo "Table $tableName has been created"
sleep 1
clear
