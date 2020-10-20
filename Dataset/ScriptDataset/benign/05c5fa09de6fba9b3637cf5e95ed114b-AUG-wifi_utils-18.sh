	if [ -n "$1" ] && [ $1 -ge 20 ] && [ $1 -le 1000 ]; then
		BCN_INTERVAL=$1
	else
		BCN_INTERVAL=100
	fi
	echo "$BCN_INTERVAL"
