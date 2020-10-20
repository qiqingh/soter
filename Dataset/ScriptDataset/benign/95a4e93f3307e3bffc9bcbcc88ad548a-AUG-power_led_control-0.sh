#!/bin/sh
pidof power_led.sh > /dev/null
if [ $? = 0 ]; then
        killall power_led.sh
fi

case "$1" in

	"blink")
		/etc/led/power_led.sh blink &
		;;

	"on")
		/etc/led/power_led.sh on &
		;;

	"off")
		/etc/led/power_led.sh off &
		;;
	"blink_t")
		/etc/led/power_led.sh blink_t &
		;;

	"blink_07")
		/etc/led/power_led.sh blink_07 &
		;;

	"blink_167")
		/etc/led/power_led.sh blink_167 &
		;;

	*)
		;;
esac
