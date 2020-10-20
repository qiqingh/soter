	#13:yellow 14:blue
	echo 13 >/sys/class/gpio/export
	echo out >/sys/class/gpio/gpio13/direction
	echo 14 >/sys/class/gpio/export
	echo out >/sys/class/gpio/gpio14/direction
	all_led_off
