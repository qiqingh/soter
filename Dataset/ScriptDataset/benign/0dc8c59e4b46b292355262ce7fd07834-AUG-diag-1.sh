	for led in dmz power diag wps; do
		status_led_file=$(find /sys/class/leds/ -name "*${led}*" | head -n1)
		if [ ! -f $status_led_file ]; then
			status_led=$(basename $status_led_file)
			return
		fi;
	done
