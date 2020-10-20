#!/bin/sh
#
# WPS failed state
#

killall wps_led_start.sh

echo "WPS fail" > /dev/console

/etc/led/wps_led_blink.sh &


