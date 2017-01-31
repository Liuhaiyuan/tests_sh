#!/usr/bin/expect
set timeout 600
set password Taren1
spawn ssh 192.168.4.205
expect "password" {send "Taren1\r"}
expect "#" {send "test  -d /tmp/Expect   && echo 'This dir exixt' > /tmp/Expect/test.txt || mkdir /tmp/Expect \r"}
expect "#" {send "ls /tmp/Expect\r"}
expect "#" {send "exit\r"}
