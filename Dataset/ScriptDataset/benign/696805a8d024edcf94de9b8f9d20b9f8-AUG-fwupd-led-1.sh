	echo "fwupd_success" > /proc/bdutil/leds
	sleep $1
	echo "fwupd_failed" > /proc/bdutil/leds
	sleep $2
