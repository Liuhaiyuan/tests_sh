#!/bin/bash
MIN=1
MAX=254
NULL=/dev/null
DOWN_LOG=error_detection_ip.log
UP_LOG=allow_detction_ip.log
rm -rf $UP_LOG
rm -rf $DOWN_LOG
for ((i=$MIN;i<=$MAX;i++))
do
	ping -i 0.01 -w 2 -c 2 192.168.4.$i &> $NULL
	if [ $? -eq 0 ];then
	#	echo "192.168.4.$i is up"  >> $UP_LOG
		echo "192.168.4.$i is up" >> ssh 192.168.4.254:/root/UP.log
	else 
		echo "192.168.4.$i is down" >> $DOWN_LOG
	fi
done
