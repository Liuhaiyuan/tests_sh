#!/bin/bash
read -p "Please input create user numbers:" U_NUMBERS
#U_NUMBERS=10  #user numbers
U_PASSWD=123456		#user default passwd
UA_ERROR=error_useradd.log		#useradd log
UP_ERROR=error_userpasswd.log	#userpass log
rm -rf $UA_ERROR
for ((i=0;i<=$U_NUMBERS;i++))
#for i in {1..10}
do
	useradd user$i 2>>$UA_ERROR
	echo $U_PASSWD | passwd --stdin user$i 2>> $UP_ERROR >> /dev/null
done
