	if [ -n "$1" ] && [ "auto" = "$1" ]; then
		RATE=-1
	elif [ "$1" = "5500000" ]; then
		RATE=5.5
	else
		RATE=`expr $1 / 1000000`
	fi
	if [ $RATE -gt 54 ]; then
		RATE=-1
	fi
	echo "$RATE"
