#!/bin/bash
echo_color(){
	case $1 in
	red)
		echo -e "\033[31m$2\033[0m";;
	green)
		echo -e "\033[32m$2\033[0m";;
	*)
		Usage : echo_color {red|green} 
	esac
}
if [ -n $1] && [ -n $2 ];then
	echo_color $1 $2
else
	echo_color "null" "null"
fi
