#!/bin/bash
read -p "Please input year num:" years
if [ $[years%400] -eq 0 ] || (  [ $[years%4] -eq 0 ]  && [ $[years%100] -ne 0 ] );then
	echo "这一年是润年。"
else 
	echo "这一年是平年。"
fi
