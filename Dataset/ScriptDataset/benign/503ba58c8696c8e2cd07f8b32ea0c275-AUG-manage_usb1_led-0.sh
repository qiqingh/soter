#!/bin/sh
#
# Manages USB1 LED
#
# USB1 is combo eSata/USB port, 2.0 and legacy only
#
# $1 is usb_port_1_state
# $2 is the event value
#

LED_CTRL=/proc/bdutil/leds

if [ ! -e $LED_CTRL ]
then
    exit 0
fi

if [ "$2" == "up" ]
then
    type=`sysevent get usb_port_1_type`
    if [ "$type" == "storage" -o "$type" == "printer" ]
    then
        echo "usb1=on" > $LED_CTRL
        exit 0
    fi
fi

echo "usb1=off" > $LED_CTRL
        
