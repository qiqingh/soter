#!/bin/sh

if [ -f /proc/bdutil/leds ]; then
	echo "blink_on" > /proc/bdutil/leds
fi

echo "`date` LED $0 $1 $2 $3" >> /var/log/messages

