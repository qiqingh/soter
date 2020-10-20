#!/bin/sh

if [ -f /proc/bdutil/leds ]; then
	echo "timeron=9" > /proc/bdutil/leds
fi

/etc/led/lib_set_solid_after.sh 120 &

echo "`date` LED $0 $1 $2 $3" >> /var/log/messages
