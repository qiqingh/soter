	echo "on"  > /proc/bdutil/leds
	sleep $1
	echo "off" > /proc/bdutil/leds
	sleep $2
