#!/bin/bash
for i in $(ls *.$1)
do
	name=${i%.*}
	mv $i $name.$2

done
