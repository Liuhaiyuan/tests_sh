read -p "Please input nums:" input
case $input in
[a-Z])
	echo "This is letter";;
[0-9])
	echo "This is number";;
*)
	echo "This is other symbol";;
esac
