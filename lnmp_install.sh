#!/bin/bash
#Data:2016-07-20
#Version:2.0
#Author:Jacob(418146150@qq.com)
#The software list:Nginx,MySQL,PHP,Memcached,memcache for php,Tomcat,Java.
#This script can automatically install all software on your machine.

#Define default variables, you can modify the value.
nginx_version=nginx-1.8.0
mysql_version=mysql-5.6.25
cmake_version=cmake-2.8.10.2
mhash_version=mhash-0.9.9.9
libmcrypt_version=libmcrypt-2.5.8
php_version=php-5.4.24
libevent_vertion=libevent-2.0.21-stable
memcached_version=memcached-1.4.24
memcache_version=memcache-2.2.5
format1=tar.gz
format2=tgz


#Determine the language environment
language(){
	echo $LANG |grep -q zh
	if [ $? -eq 0 ];then
		return 0
	else
		return 1
	fi
}
#Define a user portal menu.
menu(){
	clear
	language
	if [ $? -eq 0 ];then
	   echo "  ##############----Menu----##############"
	   echo "# 1. 安装Nginx"
	   echo "# 2. 安装MySQL"
	   echo "# 3. 安装PHP"
	   echo "# 4. 安装Memcached"
	   echo "# 5. 安装memcache for php"
	   echo "# 6. 安装Java,Tomcat"
	   echo "# 7. 安装Varnish"
	   echo "# 8. 安装Session共享库"
	   echo "# 9. 退出程序"
	   echo "  ########################################"
	else
	   echo "  ##############----Menu----##############"
	   echo "# 1. Install Nginx"
	   echo "# 2. Install MySQL"
	   echo "# 3. Install PHP"
	   echo "# 4. Install Memcached"
	   echo "# 5. Install memcache for php"
	   echo "# 6. Install Java,Tomcat"
	   echo "# 7. Install Varnish"
	   echo "# 8. Install Session Share Libarary"
	   echo "# 9. Exit Program"
	   echo "  ########################################"
	fi
}

#Read user's choice
choice(){
	language
	if [ $? -eq 0 ];then
		read -p "请选择一个菜单[1-9]:" select
	else
		read -p "Please choice a menu[1-9]:" select
	fi
}
rotate_line(){
	INTERVAL=0.1
	TCOUNT="0"
	while :
	do
		TCOUNT=`expr $TCOUNT + 1`
		case $TCOUNT in
		"1")
			echo -e '-'"\b\c"
			sleep $INTERVAL
			;;
		"2")
			echo -e '\\'"\b\c"
			sleep $INTERVAL
			;;
		"3")
			echo -e "|\b\c"
			sleep $INTERVAL
			;;
		"4")
			echo -e "/\b\c"
			sleep $INTERVAL
			;;
		*)
			TCOUNT="0";;
		esac
	done
}
error_install(){
	language
	if [ $? -eq 0 ];then
		clear
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo -e "\033[1;34m错误:编译安装[ ${1} ]失败!\033[0m"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		exit
	else
		clear
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo -e "\033[1;34mERROR:Install[ ${1} ]Failed!\033[0m"
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
              	exit
	fi
}
		
error_yum(){
	language
	if [ $? -eq 0 ];then
		clear
		echo
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "错误:本机YUM不可用，请正确配置YUM后重试."
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo
		exit
	else
		clear
		echo
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo "ERROR:Yum is disable,please modify yum repo file then try again."
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		echo
		exit
	fi
}

#Test target system whether have yum repo.
#Return 0 dedicate yum is enable.
#Return 1 dedicate yum is disable.
test_yum(){
#set yum configure file do not display Red Hat Subscription Management info.
	if [ -f /etc/yum/pluginconf.d/subscription-manager.conf ];then
	sed -i '/enabled/s/1/0/' /etc/yum/pluginconf.d/subscription-manager.conf
	fi
	yum clean all &>/dev/null
	repolist=$(yum repolist 2>/dev/null |awk '/repolist:/{print $2}'|sed 's/,//')
	if [ $repolist -le 0 ];then
		error_yum
	fi
}

#This function will check depend software and install them.
solve_depend(){
	language
	if [ $? -eq 0 ];then
		echo -en "\033[1;34m正在安装依赖包,请稍后...\033[0m"
	else
		echo -e "\033[1;34mInstalling dependent software,please wait a moment...\033[0m"
	fi
	case $1 in
	  nginx)
		rpmlist="gcc pcre-devel openssl-devel zlib-devel make"
		;;
	  mysql)
		rpmlist="gcc gcc-c++ cmake ncurses-devel perl"
		;;
	  mhash)
		rpmlist="gcc"
		;;
	  libmcrypt)
		rpmlist="gcc"
		;;
	  php)
		rpmlist="gcc libxml2-devel"
		;;
	  libevent)
		rpmlist="gcc"
		;;
	  memcached)
		rpmlist="gcc"
		;;
	  memcache)
		rpmlist="autoconf"
		;;
	esac
	for i in $rpmlist
	  do
		rpm -q $i &>/dev/null
		    if [ $? -ne 0 ];then
			yum -y install $i &>/dev/null
	            fi
	  done
}

#Display a begin mesages
begin(){
	language
	if [ $? -eq 0 ];then
		clear
		echo -e "\033[1;36m----------------------------------\033[0m"
		echo -e "\033[1;32m\t现在开始安装${1}!\033[0m"
		echo -e "\033[1;36m----------------------------------\033[0m"
	else
		clear
		echo -e "\033[1;36m-----------------------------------\033[0m"
		echo -e "\033[1;32m\tInstall ${1} Now!\033[0m"
		echo -e "\033[1;36m-----------------------------------\033[0m"
	fi
}

#If not found the software package, this script will be exit.
error_nofile(){
	language
        if [ $? -eq 0 ];then
               clear
               echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
               echo -e "\033[1;34m错误:未找到[ ${1} ]软件包,请下载软件包至当前目录.\033[0m"
               echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
               exit
        else
               clear
               echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
               echo -e "\033[1;34mERROR:Not found [ ${1} ] package in current directory, please download it.\033[0m"
               echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
               exit
        fi
}

#Display a hint for configure
configure_info(){
	language
                if [ $? -eq 0 ];then
                        echo -e "\033[1;34m正在检测编译环境,请稍后...\033[0m"
                else
                        echo -e "\033[1;34mconfigure,Please wait a moment...\033[0m"
                fi
}

#Display a hint for make and make install
make_info(){
	language
                if [ $? -eq 0 ];then
                        echo -e "\033[1;34m正在编译安装软件,请稍后...\033[0m"
                else
                        echo -e "\033[1;34mComplie and install,Please wait a moment...\033[0m"
                fi
}

install_mhash(){
	test_yum
	solve_depend mhash
	if [ -f ${mhash_version}.${format1} ];then
		tar -xf ${mhash_version}.${format1}
		cd ${mhash_version}
		configure_info
		rotate_line &
		disown $!
		./configure &>/dev/null
		result=$?
		kill -9 $!
		if [ $result -eq 0 ];then
			rotate_line &
			disown $!
			make &>/dev/null
			make install &>/dev/null
			result=$?
			kill -9 $!
		fi
		if [ $result -ne 0 ];then
			error_install mhash
		fi
			cd ..
		if [ ! -f /usr/lib/libmhash.so ];then
			ln -s /usr/local/lib/libmhash.so /usr/lib/
		fi
		ldconfig
	else
		error_nofile mhash
	fi
}
install_libmcrypt(){
	solve_depend libmcrypt
	if [ -f ${libmcrypt_version}.${format1} ];then
		tar -xf ${libmcrypt_version}.${format1}
		cd ${libmcrypt_version}
		configure_info
		rotate_line &
		disown $!
		./configure &>/dev/null
		result=$?
		kill -9 $!
		if [ $result -eq 0 ];then
			rotate_line &
			disown $!
			 make &>/dev/null
			 make install &>/dev/null
			 result=$?
			 kill -9 $!
			if [ $result -ne 0 ];then
				error_install libmcrypt
			fi
		fi
			cd ..
		if [ ! -f /usr/lib/libmcrypt.so ];then 
			ln -s /usr/local/lib/libmcrypt.so /usr/lib/
		fi
		ldconfig
	else
		error_nofile libmcrypt
	fi
}

#Install libevent
install_libevent(){
	solve_depend libevent
	if [ -f ${libevent_vertion}.${format1} ];then
		tar -xf ${libevent_vertion}.${format1}
		cd ${libevent_vertion}
		configure_info
		./configure &>/dev/null
		make &>/dev/null && make install &>/dev/null
		cd ..
		if [ ! -f /usr/lib/libevent.so ];then
			ln -s /usr/local/lib/libevent.so /usr/lib/
		fi
		ldconfig
	else
		error_nofile libevent
	fi
}
#Install Nginx
install_nginx(){
	begin nginx
	test_yum
	solve_depend nginx
	grep -q nginx /etc/passwd
	if [ $? -ne 0 ];then
	    useradd -s /sbin/nologin nginx
	fi
	if [ -f ${nginx_version}.${format1} ];then
		tar -xf ${nginx_version}.${format1}
		cd $nginx_version
		configure_info
		rotate_line &
		disown $!
		./configure --user=nginx --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module >/dev/null
		result=$?
		kill -9 $!
		make_info
		language
		if [ $? -eq 0 ];then
			echo -e "\033[1;32m软件被安装在/usr/local/nginx目录.\033[0m"
		else
			echo -e "\033[1;32mInstalle to /usr/local/nginx.\033[0m"
		fi
		if [ $result -eq 0 ];then
			rotate_line &
			disown $!
			make &>/dev/null && make install &>/dev/null
			result=$?
			kill -9 $!
			echo 'PATH=$PATH:/usr/local/nginx/sbin/' >> /etc/profile
			source /etc/profile
			cd ..
			if [ $result -ne 0 ];then
				error_install nginx
			fi
		fi
	else
		error_nofile Nginx
	fi
}


#Install MySQL
install_mysql(){
	begin mysql
	test_yum
	solve_depend mysql
	grep -q mysql /etc/passwd
	if [ $? -ne 0 ];then
		useradd -s /sbin/nologin mysql
	fi
	if [ -f ${mysql_version}.${format1} ];then
		tar -xf ${mysql_version}.${format1}
		cd ${mysql_version}
		configure_info
		rotate_line &
		disown $!
		cmake . &>/dev/null
		result=$?
		kill -9 $!
		make_info
		language
                if [ $? -eq 0 ];then
                        echo -e "\033[1;32m软件被安装在/usr/local/mysql目录.\033[0m"
                else
                        echo -e "\033[1;32mInstalle to /usr/local/mysql.\033[0m"
                fi
                if [ $result -eq 0 ];then
			rotate_line &
			disown $!
                        make &> /dev/null && make install &>/dev/null
			result=$?
			kill -9 $!
			if [ $result -ne 0 ];then
				error_install MySQL
			fi
			cd ..
                fi
		language
		if [ $? -eq 0 ];then
			echo -e "\033[1;34m正在初始化数据库...\033[0m"
		else
			echo -e "\033[1;34mInitialization database...\033[0m"
		fi
		/usr/local/mysql/scripts/mysql_install_db --user=mysql --datadir=/usr/local/mysql/data/ --basedir=/usr/local/mysql/ &>/dev/null
		chown -R root.mysql /usr/local/mysql
		chown -R mysql /usr/local/mysql/data
		/bin/cp -f /usr/local/mysql/support-files/mysql.server /etc/init.d/mysqld
		chmod +x /etc/init.d/mysqld
		/bin/cp -f /usr/local/mysql/support-files/my-default.cnf /etc/my.cnf
		echo "/usr/local/mysql/lib/" >> /etc/ld.so.conf
		ldconfig
		cat >> /etc/profile << EOF
PATH=\$PATH:/usr/local/mysql/bin/
export PATH
EOF
        else
                error_nofile mysql
	fi	
}

#Install PHP
install_php(){
	begin php
	test_yum
	install_mhash
	install_libmcrypt
	solve_depend php
	if [ -f ${php_version}.${format1} ];then
		tar -xf ${php_version}.${format1}
		cd ${php_version}
		configure_info
		rotate_line &
		disown $!
		./configure --prefix=/usr/local/php5 --with-mysql=/usr/local/mysql --enable-fpm  --enable-mbstring --with-mcrypt --with-mhash --with-config-file-path=/usr/local/php5/etc --with-mysqli=/usr/local/mysql/bin/mysql_config &>/dev/null
		result=$?
		kill -9 $!
		make_info
                language
                if [ $? -eq 0 ];then
                        echo -e "\033[1;32m软件被安装在/usr/local/php5目录.\033[0m"
                else
                        echo -e "\033[1;32mInstalle to /usr/local/php5.\033[0m"
                fi
                if [ $result -eq 0 ];then
			rotate_line &
			disown $!
                        make &> /dev/null && make install &>/dev/null
			result=$?
			kill -9 $!	
			if [ $result -ne 0 ];then
				error_install php
			fi
			/bin/cp -f php.ini-production /usr/local/php5/etc/php.ini
			/bin/cp -f /usr/local/php5/etc/php-fpm.conf.default /usr/local/php5/etc/php-fpm.conf
			cd ..
                fi
	else
		error_nofile php
	fi
}

#Install memcached
install_memcached(){
	begin memcached
	test_yum
	install_libevent
	solve_depend memcached
	if [ -f ${memcached_version}.${format1} ];then
		tar -xf ${memcached_version}.${format1}
		cd ${memcached_version}
		configure_info
		rotate_line &
		disown $!
		./configure &>/dev/null && make &>/dev/null && make install &>/dev/null
		result=$?
		kill -9 $!
		if [ $result -ne 0 ];then
			error_install memcached
		fi
		cd ..
	else
		error_nofile memcached
	fi
}

#Install memcahe module for php
install_memcache(){
	begin memcache
	if [ ! -f /usr/local/php5/bin/phpize ];then
		language
		if [ $? -eq 0 ];then
			clear
			echo -e "\033[1;34m错误:未安装PHP.\033[0m"
			exit
		else
			clear
			echo -e "\033[1;34mERROR:Can't found PHP.\033[0m"
			exit
		fi
	else
		if [ -f ${memcache_version}.${format2} ];then
			tar -xf ${memcache_version}.${format2}
			cd ${memcache_version}
			solve_depend memcache
			configure_info
			rotate_line &
			disown $!
			/usr/local/php5/bin/phpize . &>/dev/null
			./configure --with-php-config=/usr/local/php5/bin/php-config --enable-memcache &>/dev/null
			make_info
			make &>/dev/null && make install &>/dev/null
			result=$?
			kill $!
			if [ $result -ne 0 ];then
				error_install memcache
			fi
			cd ..
			sed -i '728i extension_dir = "/usr/local/php5/lib/php/extensions/no-debug-non-zts-20100525/"' /usr/local/php5/etc/php.ini
			sed -i '856i extension=memcache.so' /usr/local/php5/etc/php.ini
		fi

	fi
}

#Install JRE
install_java(){
	begin JAVA
	rpm -vih jdk-8u77-linux-x64.rpm &>/dev/null
}

#Install Tomcat
install_tomcat(){
	begin Tomcat
	if [ -f apache-tomcat-8.0.30.tar.gz ];then
		tar -xzf apache-tomcat-8.0.30.tar.gz &>/dev/null
		mv apache-tomcat-8.0.30 /usr/local/tomcat
	else
		error_nofile tomcat
	fi
}
install_session(){
	begin session
	cp session/*.jar /usr/local/tomcat/lib/
#	/bin/cp -f session/context.xml /usr/local/tomcat/conf/
	cp session/test.jsp /usr/local/tomcat/webapps/ROOT/
}
install_varnish(){
	test_yum
	yum -y install gcc readline-devel pcre-devel &>/dev/null
	useradd -s /sbin/nologin varnish
	tar -xf varnish-3.0.6.tar.gz
	cd varnish-3.0.6
	./configure --prefix=/usr/local/varnish
	make && make install
	cp redhat/varnish.initrc /etc/init.d/varnish
	cp redhat/varnish.sysconfig /etc/sysconfig/varnish
	cp redhat/varnish_reload_vcl /usr/bin/
	ln -s /usr/local/varnish/sbin/varnishd /usr/sbin/
	mkdir /etc/varnish
	cp /usr/local/varnish/etc/varnish/default.vcl /etc/varnish/
	uuidgen > /etc/varnish/secret
}

while :
do
menu
choice
case $select in
1)
	install_nginx
	;;
2)
	install_mysql
	;;
3)
	install_php
	;;
4)
	install_memcached
	;;
5)
	install_memcache
	;;
6)
	install_java
	install_tomcat
	;;
7)
	install_varnish
	;;
8)
	install_session
	;;
9)
	exit
	;;
*)
	echo Sorry!
esac
done
