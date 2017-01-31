NULL=/dev/null
netstat -anptu | grep :80 > $NULL
if [ $? -eq 0 ];then
	echo "The port started"
else
	service httpd restart  &> $NULL
	echo "Start service  httpd now"
fi
