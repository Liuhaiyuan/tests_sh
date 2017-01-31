#!/bin/bash
GAMETIME=5
WINTIME=3
USER_WINS=0
COMP_WINS=0
WINOUTPUT="You Win,Good."
DRAWOUTPUT="Draw,please try agin."
LOSEOUTPUT="You Lose,Come on!"
RESULTOUTPUT="Congratulation"
echo "#########################################"
echo -e "# Welcome to game!"
echo -e "# Input options : stone:1,shears:2,fabric:3"
echo -e "# Now,game start"
echo -e "######################################"

for ((i=1;i<=$GAMETIME;++i))
do
	if [ $i -ge 2 ];then
		#echo "USER_WINS=$USER_WINS,COMP_WINS=$COMP_WINS"
		if [ $USER_WINS -eq $WINTIME ] || [ $COMP_WINS -eq $WINTIME ];then
			break
		fi
	fi

	read -p "Please input you guess nums:" user_guess
	comp_guess=$[RANDOM%3+1]

	case $user_guess in 
	1)
		if [ $user_guess -eq $comp_guess ];then
			echo $DRAWOUTPUT
			let i--
			continue
		elif [ $comp_guess -eq 2 ];then
			echo $WINOUTPUT
			let USER_WINS++
			continue
		elif [ $comp_guess -eq 3 ];then
			echo $LOSEOUTPUT
			let COMP_WINS++
			continue
		fi
		;;
	2)
		if [ $user_guess -eq $comp_guess ];then
			echo $DRAWOUTPU
			let i--
			continue
		elif [ $comp_guess -eq 1 ];then
			echo $LOSEOUTPUT
			let COMP_WINS++
			continue
		elif [ $comp_guess -eq 3 ];then
			echo $WINOUTPUT
			let USER_WINS++
			continue
		fi
		;;
	3)	
		if [ $user_guess -eq $comp_guess ];then
			echo $DRAWOUTPUT
			let i--
			continue
		elif [ $comp_guess -eq 1 ];then
			echo $LOSEOUTPUT
			let COMP_WINS++
			continue
		elif [ $comp_guess -eq 2 ];then
			echo $WINOUTPUT
			let USER_WINS++
			continue
		fi
		;;
	*)
		echo "Input Error,Please try again!"
		let i--
		continue
		;;
	esac
done

echo "#############################################"
echo "END"
echo "USER_WINS=$USER_WINS,COMP_WINS=$COMP_WINS"
if [ $USER_WINS -gt $COMP_WINS ];then
	echo "$RESULTOUTPUT User Win."
elif [ $USER_WINS -lt $COMP_WINS ];then
	echo "$RESULTOUTPUT Computer Win."
else 
	echo "Error,USER_WINS=$USER_WINS,COMP_WINS=$COMP_WINS"
fi
