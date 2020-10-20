#!/bin/sh

if [ -f /proc/bdutil/pwmled ]; then
	echo "blinking=off" > /proc/bdutil/pwmled
	echo "pulsing=on" > /proc/bdutil/pwmled
fi

echo "`date` LED $0 $1 $2 $3" >> /var/log/messages

