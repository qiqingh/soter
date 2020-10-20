#!/bin/sh

if [ "started" = "`sysevent get processing_wps`" ]; then
	echo "Don't press WPS button again" > /dev/console
	exit 0
fi

sysevent set processing_wps started
sysevent set wps-status start

if [ -f /proc/bdutil/leds ]; then
	#in mod_bdutil it only maching the first 8 worlds,so it work just like blink_on when activity light don't turn off on UI
	echo "blink_on_wps" > /proc/bdutil/leds
	echo "timeron=10" > /proc/bdutil/leds
fi

/etc/led/lib_set_solid_after.sh 120 &

echo "`date` LED $0 $1 $2 $3" >> /var/log/messages

