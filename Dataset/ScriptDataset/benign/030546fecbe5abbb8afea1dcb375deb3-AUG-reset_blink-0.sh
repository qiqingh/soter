#!/bin/sh
#
# System ready
#

LED_CTRL=/proc/bdutil/leds

if [ ! -e $LED_CTRL ]
then
    exit 0
fi

echo "pwm=blink" > $LED_CTRL


