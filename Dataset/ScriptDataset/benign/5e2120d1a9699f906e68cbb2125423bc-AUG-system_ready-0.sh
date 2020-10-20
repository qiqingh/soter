#!/bin/sh
#
# System ready
#

LED_CTRL=/proc/bdutil/leds

if [ ! -e $LED_CTRL ]
then
    exit 0
fi

echo "pwm=on" > $LED_CTRL


