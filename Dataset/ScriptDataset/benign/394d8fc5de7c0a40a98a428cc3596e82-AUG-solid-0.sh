#!/bin/sh

if [ -f /proc/bdutil/leds ]; then
	echo "blink_off" > /proc/bdutil/leds
	echo "on" > /proc/bdutil/leds
fi

echo "`date` LED $0 $1 $2 $3" >> /var/log/messages

