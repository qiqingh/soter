#!/bin/sh
#
# WPS success state
#

echo "WPS success" > /dev/console

/etc/led/power_wps_led_control.sh power_led_on

