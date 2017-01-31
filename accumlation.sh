#!/bin/bash
read -p "Please input one num:" num
sum=0
echo ${num:=1}
for ((i=0;i<=num;i++))
do
	#$[sum+=i] 
	let sum+=i
	#sum=$[sum+i]
done
echo "sum=$sum"
