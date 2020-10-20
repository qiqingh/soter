#!/bin/sh
#
# Sets all LED to default behavior
#

LED_CTRL=/proc/bdutil/leds

if [ ! -e $LED_CTRL ]
then
    exit 0
fi

echo "lan=default" > $LED_CTRL


