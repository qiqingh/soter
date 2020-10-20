#!/bin/sh

if [ -f /proc/bdutil/leds ]; then
	echo "blink_on" > /proc/bdutil/leds
fi

/etc/led/lib_set_solid_after.sh 240 &

echo "`date` LED $0 $1 $2 $3" >> /var/log/messages

