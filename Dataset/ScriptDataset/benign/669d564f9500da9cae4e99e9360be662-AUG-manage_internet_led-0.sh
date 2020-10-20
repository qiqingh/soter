#!/bin/sh
#
# Manages WAN LED
#

state=$1
if [ "$state" == "link_down" ]
then
    # link down
    /etc/led/internet_led_control.sh yellow_blink
    exit 0
fi

if [ "$state" == "link_up" ]; then
    # link up, protocol up, but internet down
    /etc/led/internet_led_control.sh yellow_on
    exit 0
fi
   
if [ "$state" == "off" ]; then
    /etc/led/internet_led_control.sh off
    exit 0
fi

# link up, protocol up, and internet up
#/etc/led/internet_led_control.sh blue_on
/etc/led/internet_led_control.sh blue_r

