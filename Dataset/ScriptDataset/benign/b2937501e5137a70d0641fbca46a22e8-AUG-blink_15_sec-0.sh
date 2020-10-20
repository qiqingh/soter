#!/bin/sh

if [ "error" = "`sysevent get wps-status`" ]; then
	echo "WPS fail already happen" > /dev/console
	exit 0
fi

sysevent set wps-status error

# blink LED
if [ -f /proc/bdutil/leds ]; then
	#in mod_bdutil it only maching the first 8 letters,so it work just like blink_on when activity light don't turn off on UI
	echo "blink_on_wps" > /proc/bdutil/leds
	echo "timeron=5" > /proc/bdutil/leds
fi

/etc/led/lib_set_solid_after.sh 15 &

echo "`date` LED $0 $1 $2 $3" >> /var/log/messages
