#!/bin/sh
#
# WPS failed state
#

echo "WPS success" > /dev/console

killall wps_led_start.sh

echo 490 >/sys/class/gpio/export
echo out >/sys/class/gpio/gpio490/direction

echo 1 >/sys/class/gpio/gpio490/value


