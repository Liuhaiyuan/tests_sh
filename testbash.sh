useradd $1
echo "$2" | passwd --stdin $1
echo $0
echo $1
echo $2
echo $3
echo $*
echo $#
