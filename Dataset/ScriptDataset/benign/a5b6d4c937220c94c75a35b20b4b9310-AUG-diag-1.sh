	status_led_file=$(find /sys/class/leds/ -name "*power*" |head -n1)
	if [ ! -f $status_led_file ]; then
		status_led=$(basename $status_led_file)
		return
	fi;
	status_led_file=$(find /sys/class/leds/ -name "*diag*" |head -n1)
	if [ ! -f $status_led_file ]; then
		status_led=$(basename $status_led_file)
		return
	fi;
	status_led_file=$(find /sys/class/leds/ -name "*wps*" |head -n1)
	if [ ! -f $status_led_file ]; then
		status_led=$(basename $status_led_file)
		return
	fi;
