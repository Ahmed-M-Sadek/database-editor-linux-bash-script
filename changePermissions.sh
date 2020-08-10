#! /bin/bash

arr+=$(ls $1)

for i in ${arr[@]}
do
chmod +x $1/$i
done

