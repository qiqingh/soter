#!/bin/sh
#
# USB2 umount event
#
# USB2 is standalone USB port, 3.0, 2.0 and legacy
#

LED_CTRL=/proc/bdutil/leds

if [ ! -e $LED_CTRL ]
then
    exit 0
fi

echo "usb2a=off" > $LED_CTRL
echo "usb2b=off" > $LED_CTRL
        
