#!/bin/bash
for i in {1..5}
do 
	#[ $i -eq 3 ] && break
	#[ $i -eq 3 ] && continue
	[ $i -eq 3 ] && exit
	echo $i
done
echo End
