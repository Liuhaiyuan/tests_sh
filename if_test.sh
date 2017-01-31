num=1
if [ $num -eq 1 ] ; then
	echo "num is $num $"
fi
max=10
for i in {1..$max}
do
	num2=$[RANDOM%3]
	if [ $num2 -eq 2 ];then
		echo "num2 is 2,The Way is right"
	else 
		echo "this way is Wrong!"
	fi
done
