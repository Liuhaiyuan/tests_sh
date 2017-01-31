#!/bin/bash
while :
do
	clear
	echo -e  "\033[34m#######################################"
	echo "#examine computer info"
	echo "#1.CPU info"
	echo "#2.network info"
	echo "#3.exit"
	echo -e "#######################################\033[0m"
	read -p  "#Please input choose num:" choose
	case $choose in
	1)
		cat /proc/cpuinfo | grep -i CPU
		read -p "Please go on Enter..."
		continue
	;;
	2)
		ifconfig eth0 | grep "inet addr"
		read -p "Please go on Enter..."  
		continue
	;;
	3)
		exit
	;;
	*)
		echo "Input error,Please try again!"
	;;
	esac
#	read -p "Please go on Enter..."
	#clear
done

