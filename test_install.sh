[ $USER != root ] && echo "Not USER Root" && exit
yum -y install ftp

[ $HISTSIZE == 1000 ] && history -c && echo $HISTSIZE
