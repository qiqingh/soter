	IFNAME=$1
	STATE=`ifconfig $IFNAME | grep MTU | awk '/UP/ {print $1}'`
	if [ ! -z "$STATE" ] && [ "$STATE" = "UP" ]; then
		STATE="UP"
	else
		STATE="DOWN"
	fi
	echo "$STATE"
