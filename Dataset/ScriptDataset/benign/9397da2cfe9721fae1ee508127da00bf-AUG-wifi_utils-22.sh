	PHY_IF=$1
	STATE=`ifconfig $PHY_IF | grep MTU | awk '/UP/ {print $1}'`
	if [ ! -z "$STATE" ] && [ "$STATE" = "UP" ]; then
		STATE="up"
	else
		STATE="down"
	fi
	echo "$STATE"
