#!/bin/sh

echo "system_error" > /proc/bdutil/leds

echo "`date` LED $0 $1 $2 $3" >> /var/log/messages
