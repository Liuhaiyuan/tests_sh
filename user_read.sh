NULL=/dev/null
read -p "Please input username:" username
stty -echo
read -t 7 -p "Please input password,and timeout is 7 seconds:" password
stty echo
echo ""
id $username  &> $NULL
if [ $? -eq 0 ]
then
	echo " This username is already exits!"
else
	useradd $username  > $NULL
	echo $password | passwd --stdin $username >$NULL
	echo " Request Successfully!"
fi
