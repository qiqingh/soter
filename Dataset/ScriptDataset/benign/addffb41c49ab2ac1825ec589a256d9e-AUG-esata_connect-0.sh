#!/bin/sh
#
# USB1 umount event
#
# USB1 is combo eSata/USB port, 2.0 and legacy only
#


LED_CTRL=/proc/bdutil/leds

if [ ! -e $LED_CTRL ]
then
    exit 0
fi

echo "esata=on" > $LED_CTRL

