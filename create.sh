#!/bin/bash
clear

echo "Kindly enter your new database name:"
read name

flag=1
while [ $flag -eq 1 ]
do
if [[ $name =~ ^[a-zA-Z]+$ ]]
then
mkdir $name 2>$1/errors.txt
	if [ $? -eq 0 ]
	then
	flag=0
	tput cup 10 20
	echo "$name DB has been created Successfully"
	else
	echo "The $name DB already exists"
	sleep 2
	tput cup 1 0
	tput ed
	read name
	fi
else
echo "Invalid name, DB name should only contain letters!"
sleep 2
tput cup 1 0
tput ed
read name
fi
done
sleep 2
clear
