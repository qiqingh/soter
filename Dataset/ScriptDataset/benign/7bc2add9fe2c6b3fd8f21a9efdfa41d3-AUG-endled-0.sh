#!/bin/sh
#
# LED end
#

echo "LED end" > /dev/console

/etc/led/power_wps_led_control.sh power_led_on

