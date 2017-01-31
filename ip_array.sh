#!/bin/bash
OVER=EOF
i=0
echo "Ipaddress List,Input $OVER over."
while :
read -p "Please input ip address:" ipaddress

do
	if [ $ipaddress == $OVER ];then
		let i-=1
		break
	else
		ip_array[$[i++]]=$ipaddress
	fi
done

echo "#########################"
echo "$i"
echo "This is ip list:"
n=0
for ((;i>=0;i--))
do
	echo "$[n+1]======:${ip_array[$n]}"
	let n++
done
