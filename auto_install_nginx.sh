#!/bin/bash
# exit 29 --> no such tar file
# exit 30 --> yum repolist fail
# exit 31 --> software depending install fail
# exit 32 --> configure fail
# exit 33 --> make fail
# exit 34 --> make install fail
#static variable
NULL=/dev/null
TAR_FILE_ERROR=29
YUM_LIST_ERROR=30
SOFT_DEPEND_ERROR=31
CONFIGURE_ERROR=32
MAKE_ERROR=33
MAKE_INSTALL_ERROR=34
#software depending
GCC="gcc*"
PRCE="pcre-devel"
ZLIB="zlib-devel"

NGINX="nginx-1.8.0.tar.gz"
CONFIGURE_FILE="configure"
INSTALLED_DIR="/usr/local/nginx/"


##nginx 是一块模块化的软件，在配置时需要选择的功能。
##本脚本会选泽其中的两个模块进行安装
##--with-http_stub_status_module --with-http_ssl_module


test_yum () {
	
	yum clean all > $NULL
	yum_repolists=$(yum repolist | awk '/repolist:/{print $2}' | sed 's/,//')
	if [ $yum_repolists -gt 0 ];then
		echo -e "yum repolist\t\t\t\t \e[32;1m[Success]\e[0m"
	else
		echo -e "yum repolist\t\t\t\t \e[31;1m[Fail]\e[0m"
		exit $YUM_LIST_ERROR
	fi
}


grep "nginx" /etc/passwd &> $NULL
if [ $? -ne 0 ];then
	useradd -s /sbin/nologin/ nginx
fi

test_yum
yum -y install $GCC $PRCE $NGINX > $NULL
if [ $? -eq 0 ];then
	echo  -e "software depending install\t\t \e[32;1m[Success]\e[0m"
else
	echo  -e "software depending install\t\t \e[31;1m[Fail]\e[0m"
	exit $SOFT_DEPEND_ERROR
fi

if [ ! -f $NGINX ];then
	exit TAR_FILE_ERROR
fi

NGINX_TAR_DIR=$(tar -tf $NGINX | head -1)
tar -xf $NGINX &> $NULL
cd $NGINX_TAR_DIR
if [ -f $CONFIGURE_FILE ];then
	./configure --user=nginx --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module > $NULL
	if [ $? -eq 0 ];then
		echo  -e "configure\t\t\t\t \e[32;1m[Success]\e[0m"
	else
		echo  -e "configure\t\t\t\t \e[31;1m[Fail]\e[0m"
		exit $CONFIGURE_ERROR
	fi
fi

make > $NULL
if [ $? -eq 0 ];then
	echo  -e "make\t\t\t\t\t \e[32;1m[Success]\e[0m"
else
	echo  -e "make\t\t\t\t\t \e[31;1m[Fail]\e[0m"
	exit $MAKE_ERROR
fi

make install > $NULL
if [ $? -eq 0 ];then
	echo  -e "make install\t\t\t\t \e[32;1m[Success]\e[0m"
else
	echo  -e "make install\t\t\t\t \e[31;1m[Fail]\e[0m"
	exit $MAKE_INSTALL_ERROR
fi

ls $INSTALLED_DIR > $NULL
if [ $? -eq 0 ];then
	echo  -e "$NGINX install\t\t \e[32;1m[Success]\e[0m"
else
	echo  -e "$NGINX install\t\t \e[31;1m[Fail]\e[0m"
	exit $MAKE_INSTALL_ERROR
fi
