#!/bin/sh
#
# Manages USB2 LED
#
# USB2 is standalone USB port, 3.0, 2.0 and legacy
#
# $1 is usb_port_2_state
# $2 is the event value
#

LED_CTRL=/proc/bdutil/leds

if [ ! -e $LED_CTRL ]
then
    exit 0
fi

if [ "$2" == "up" ]
then
    type=`sysevent get usb_port_2_type`
    if [ "$type" == "storage" -o "$type" == "printer" ]
    then
        echo "usb2a=on" > $LED_CTRL

        # USB 3.0 LED indicator
        speed=`sysevent get usb_port_2_speed`
        if [ "$speed" == "5000" ]
        then
            echo "usb2b=on" > $LED_CTRL
        else
            echo "usb2b=off" > $LED_CTRL
        fi

        exit 0
    fi
fi

echo "usb2a=off" > $LED_CTRL
echo "usb2b=off" > $LED_CTRL
        
