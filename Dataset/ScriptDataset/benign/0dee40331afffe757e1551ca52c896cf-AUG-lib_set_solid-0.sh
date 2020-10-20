#!/bin/sh

if [ "start" != "`sysevent get wps-status`" ]; then
	if [ -f /proc/bdutil/leds ]; then
		if [ "started" = "`sysevent get processing_wps`" ]; then
			sysevent set processing_wps stoped
		fi
	
		#stop blink the WPS LED
		echo "blink_off" > /proc/bdutil/leds 
		#the WPS LED is triggered by low power on Panamera,set "on" actually turn off the LED
		echo "on" > /proc/bdutil/leds 
	fi
else
	sysevent set wps-failed
fi

