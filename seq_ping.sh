#!/bin/bash
net=172.40.58
max=254
min=100
NULL=/dev/null
for i in $(seq $min $max)
do
	ping -c 2 -i 0.2 -w 0.2 $net.$i &> $NULL
	if [ $? -eq 0 ];then
		echo "This host $net.$i ,ping success!"
	else 
		echo "This host $net.$i ,ping failed!"
	fi
done
