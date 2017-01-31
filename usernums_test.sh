#!/bin/bash
LOGIN_USER_NUMS=$(who | wc -l)
echo $LOGIN_USER_NUMS
[ $LOGIN_USER_NUMS -gt 2 ] && mail -s "Warning Login" root < /etc/passwd
