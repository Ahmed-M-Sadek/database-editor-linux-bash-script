#!/bin/bash

# A function that deletes an entire record of a table
# Pass the PK as $1
# Pass the table's absolute path as $2

deleteRecord() {

# get the record's number
myNR=$(awk -F: -v var=$1 '{if($1 == var && NR > 3) print NR}' "$2")

# print the new table
sed -i "$myNR d" "$2"

}

# =====================================================================

# A function to check for the PK value
# Pass the PK's new Value as $1
# Pass the table's absolute path as $2
# Pass the type's value as $3

checkPK() {

flag=1
tmp=$(awk -F: '{if(NR > 3) print $1}' "$2")


if [ $3 = "s" ]
then
	if ! [[ $1 =~ ^[A-Za-z] ]]
	then
	echo "Please enter a string!"
	flag=1
	else
	flag=0
	fi
	
	if [[ "${tmp[*]}" =~ (^|[[:space:]])"$1"($|[[:space:]]) ]]
	then
	echo "The PK value needs to be unique!"
	flag=1
	else
	flag=$((($flag)|0))
	fi
else

	if ! [[ $1 =~ ^-?[0-9]+$  ]] 
	then
	echo "Please enter an integer!"
	flag=1
	else
	flag=0
	fi
	
	if [[ "${tmp[*]}" =~ (^|[[:space:]])"$1"($|[[:space:]]) ]]
	then
	echo "The PK value needs to be unique!"
	flag=1
	else
	flag=$((($flag)|0))
	fi

fi

return $flag

}

# A function to check for the normal value
# Pass the PK's new Value as $1
# Pass the type's value as $2

checkValue() {

flag=1

if [ $2 = "s" ]
then
	if ! [[ $1 =~ ^[A-Za-z] ]]
	then
	echo "Please enter a string!"
	flag=1
	else
	flag=0
	fi
else

	if ! [[ $1 =~ ^-?[0-9]+$  ]]
	then
	echo "Please enter an integer!"
	flag=1
	else
	flag=0
	fi

fi

return $flag

}


# =====================================================================

# A function that modifies a specific cell in a record
# Pass the PK as $1
# Pass the table's absolute path as $2

modifyCell() {

# get the record's number

myNR=$(awk -F: -v var=$1 '{if($1 == var && NR > 3) print NR}' "$2")

# get number of fields
myNF=$(awk 'NR==1' "$2")

# Ask for the cell's Number
echo "Which cell do you need to modify? Enter the column's number."
tput sc
read cellNumber

until [[ $cellNumber =~ ^-?[0-9]+$  ]] && [ $cellNumber -le $myNF -a $cellNumber -gt 0 ]
do
	echo "Invalid cell Number! Please enter a number between [1-$myNF]."

	sleep 2
	tput rc
	tput ed

	read cellNumber
done

# Give the user available PKs
if [ $cellNumber -eq 1 ]
then
echo "Used PKs are: "
awk -F: 'BEGIN {ORS=" "}; {if(NR>3) print $1}' "$2"
echo $'\n'
fi 

# Get the field's data type
fieldType=$(awk -F: -v var=$cellNumber '{if(NR==2)print $var}' "$2")

# Get the new value of the user 
if [ $fieldType = "n" ]
then
echo "Enter the new INTEGER cell value: "
else
echo "Enter the new STRING cell value: "
fi

tput sc
read newValue

# Perform required checks 
if [ $cellNumber -eq 1 ]
then

flag=1

until [ $flag -eq 0 ]
do

checkPK $newValue $2 $fieldType
flag=$?

if [ $flag -eq 1 ]
then
sleep 1
tput rc
tput ed
read newValue
fi

done
else

flag=1

until [ $flag -eq 0 ]
do

checkValue $newValue $fieldType
flag=$?

if [ $flag -eq 1 ]
then
sleep 1
tput rc
tput ed
read newValue
fi

done
fi

# Replace the new value
awk -i inplace -F: -v var=$myNR -v var2=$cellNumber -v value=$newValue 'BEGIN{OFS=":";} {if(NR==var){gsub($var2,value,$var2)};{print $0}}' $2

clear
tput cup 10 20
echo "Table edited successfully"
sleep 1
clear
}

