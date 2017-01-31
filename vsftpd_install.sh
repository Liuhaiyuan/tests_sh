#!/bin/bash
NULL=/dev/null
ERROR_VSFTPD=error_vsftpd.log
yum -y install vsftpd > $NULL 2> $ERROR_VSFTPD
service vsftpd restart
service vsftpd status
chkconfig vsftpd on
chkconfig vsftpd --list
