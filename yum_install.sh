#!/bin/bash
YUM_BASEURL=http://192.168.4.254/rhel6
#cd /etc/yum.repos.d/
#mkdir bak_repo
#mv *.repo bak_repo
rm -rf /etc/yum.repos.d/*
cd /etc/yum.repos.d/
echo "[yum_install]
name=yum install
baseurl=$YUM_BASEURL
enable=1
gpgcheck=0"  > yum_install.repo
yum clean all
yum repolist

if [ $? -eq 0 ]; 
then
	chmod +x /root/Shell/vsftpd_install.sh
	/root/Shell/vsftpd_install.sh
fi

