#!/bin/bash
read -p "Please input fraction:" fraction
if [ $fraction -ge 90 ];then
	echo "S"
elif [ $fraction -ge 80 ];then
	echo "A"
elif [ $fraction -ge 70 ];then
	echo "B"
elif [ $fraction -ge 60 ];then
	echo "C"
else 
	echo "D"
fi
