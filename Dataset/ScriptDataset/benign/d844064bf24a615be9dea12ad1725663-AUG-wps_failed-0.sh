#!/bin/sh
#
# WPS failed state
#


echo "WPS fail" > /dev/console

/etc/led/power_wps_led_control.sh wps_led_blink

