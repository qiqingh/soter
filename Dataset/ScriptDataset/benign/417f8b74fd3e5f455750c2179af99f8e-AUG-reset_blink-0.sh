#!/bin/sh

if [ -f /proc/bdutil/leds ]; then
	RS=`nvram get nvram_factory_reset`
	[ -n "$RS" ] && echo "blink_on" > /proc/bdutil/leds
fi

echo "`date` LED $0 $1 $2 $3" >> /var/log/messages

