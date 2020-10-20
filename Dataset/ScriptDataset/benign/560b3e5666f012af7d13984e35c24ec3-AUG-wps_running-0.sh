#!/bin/sh
#
# WPS failed state
#

echo "START WPS" > /dev/console

killall wps_led_blink.sh

/etc/led/wps_led_start.sh &

