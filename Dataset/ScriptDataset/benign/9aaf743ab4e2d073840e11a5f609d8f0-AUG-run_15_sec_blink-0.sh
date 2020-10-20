#!/bin/sh

# blink LED
if [ -f /proc/bdutil/leds ]; then
	echo "blink_on" > /proc/bdutil/leds
fi

sleep 15

# go to solid LED
if [ -f /proc/bdutil/leds ]; then
	/etc/led/solid.sh
fi
