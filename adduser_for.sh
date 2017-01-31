#!/bin/bash
USERLIST=userlist.txt
for username in $(cat $USERLIST)
do
	useradd $username
	echo "123456" | passwd --stdin $username
	chage -d 0 $username
done
