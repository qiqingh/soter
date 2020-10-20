#!/bin/sh

DECI_SECS=$1

if [ -z $DECI_SECS ]; then
	DECI_SECS=10;
fi

if [ -f /proc/bdutil/leds ]; then
	echo "timeron=$DECI_SECS" > /proc/bdutil/leds
fi

