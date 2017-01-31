#!/bin/bash
ip=205
password=Taren1
expect <<END
set timeout 600
spawn ssh 192.168.4.205
expect {
	"yes/no)?" {send "yes\r";exp_continue}
	"password" {send "$password\r"}
}
expect "#" {send "test -d /tmp/Expect && echo 'created Expect' > /tmp/Expect/tset.txt || mkdir /tmp/Expect\r"}
expect "#" {send "test -f /tmp/Expect/test.txt && echo 'second input test' >> /tmp/Expect/test.txt || echo 'first input test' > /tmp/Expect/test.txt\r"}
expect "#" {send "exit\r"}
END
