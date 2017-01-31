ROOT=/root
ls /root/ > root_list.txt
mkdir root_tar
for filename in $(cat root_list.txt)
do
	tar -zcf root_tar/$filename.tar.gz /root/$filename
done
