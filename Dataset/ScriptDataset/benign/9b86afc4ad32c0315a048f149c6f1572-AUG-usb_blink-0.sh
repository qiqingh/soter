#!/bin/sh

USB_INDEX=`sysevent get usb_led_index`
if [ -f /proc/bdutil/leds ]; then
	echo "usb${USB_NUM}led_on" > /proc/bdutil/leds
fi

/etc/led/lib_set_solid_after.sh usb ${USB_INDEX} &

echo "`date` LED $0 $1 $2 $3" >> /var/log/messages
