#!/bin/sh
#
# LED init
#

echo "LED init" > /dev/console

/etc/led/power_wps_led_control.sh power_led_blink
/etc/led/manage_internet_led.sh off

