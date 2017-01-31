#
YUM_URL="http://192.168.4.254/rhel6"
YUM_REPOS_D="/etc/yum.repos.d"
NULL=/dev/null

#
#cd /etc/yum.repos.d/
rm -rf $YUM_REPOS_D/*
#mkdir backup 
#mv * backup
read -p "Is use default configure ? (y/n) " is_defauled
if [ $is_defauled == "y" ]
then
	echo  "[rhel6_yum]
name=default
baseurl=$YUM_URL
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release" > $YUM_REPOS_D/yum_rhel6.repo

elif [ $is_defauled == "n" ]
then
	read -p "Please input yum_url:" YUM_URL
	echo $YUM_URL
	echo "[yum1_rhel6]
name=user
baseurl=$YUM_URL
gpgcheck=0" > $YUM_REPOS_D/yum_rhel6.repo

else	
	echo "[rhel6_yum]
name=default
baseurl=$YUM_URL
gpgcheck=0" > $YUM_REPOS_D/yum_rhel6.repo
fi
#cat /etc/yum.repos.d/yum_rhel6.repo
yum clean all > $NULL
yum repolist > $NULL
if [ $? -eq 0 ]
then
#
	for ((i=0;;i++))
	do
		echo "#################################################"
		echo "#	   Service Install Services List With Yum"
		echo "#Please inputs numbers or serviceName"
		echo "# 1.vsftpd ---FTP Service			  "
		echo "# 2.httpd ---Web Service 			"
		echo "# 3.named ---DNS Service			"
		echo "# 4.dhcp ---DHCP Service 			"
		echo "# 5.Other Service					"
		echo "# 6.Quit							"
		echo "################################################"
		read -p "Please input your choose:" chooseNum
		
		case $chooseNum in
		1) 
			yum -y install vsftpd > $NULL
			service vsftpd restart  > $NULL
			chkconfig vsftpd on 	> $NULL
			chkconfig vsftpd --list 
			service vsftpd status
			;;
		2)
			yum -y install httpd > $NULL
			service httpd restart > $NULL
			chkconfig httpd on > $NULL
			chkconfig httpd --list
			service httpd status
			;;
		3)
			yum -y install bind bind-chroot > $NULL
			service named restart           > $NULL
			chkconfig named on   			> $NULL
			chkconfig named --list
			service named status
			;;
		4)
			yum -y install dhcp	> $NULL
			service dhcpd restart > $NULL
			chkconfig dhcpd on > $NULL
			chkconfig dhcpd --list
			service dhcpd status
			;;
		5)
			read -p "Please input service name:" other_service_name
			yum -y install $other_service_name > /var/other.log  2> /var/other_error.log
			;;
			#lines={ cat -n /var/other_error.log | wc -l }
			#if [ $lines = 0 ]
			#then
			#echo "Install $other_service_name Success."
			#fi
			#cat /var/other_error.log
		6) 
			#break;
			exit;;
		*) 
			echo "Error Input,Please try again."
			exit;;
		esac
	done
fi
