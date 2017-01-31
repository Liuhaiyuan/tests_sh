#!/bin/bash
max=10
counts=100
num=$[RANDOM%counts]
for ((i=0;i<$max;i++))
#for i in {1..4}
do
	#echo $num
	read -p "This is random num,you have 10 times,please input:" guess
	if [ $guess -eq $num ];then
		echo "This way right,input nums is $i times"
		exit
	elif [ $guess -gt $num ];then
		echo "guess > random num,so try again."
	elif [ $guess -lt $num ];then
		echo "guess < random num,so try again."
	fi
done
