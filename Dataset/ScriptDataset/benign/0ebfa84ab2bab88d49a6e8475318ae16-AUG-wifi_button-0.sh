#!/bin/sh
LED_STATUS=`syscfg get wifi_led_status`
WL1_STATUS=`syscfg get wl1_state`
WL0_STATUS=`syscfg get wl0_state`
BAND_STEER=`syscfg get wifi::band_steering_configure`
PBC_STATUS=`sysevent get wifi_button-status`
STATUS=`sysevent get wifi-status`
echo "wifi status is ${STATUS}"
if [ "started" != "`sysevent get lan-status`" ] ; then
	echo "${SERVICE_NAME}, LAN is not started,ignore the request"> /dev/console
	exit 0
fi
if [ "1" = "${BAND_STEER}" ]; then #for spyder
	WL2_STATUS=`syscfg get wl2_state`
	if [ "down" = "${LED_STATUS}" ]; then
		if [ "released" = "${PBC_STATUS}" ] || [ "" = "${PBC_STATUS}" ]; then
			if [ "down" = "${WL1_STATUS}" ] && [ "down" = "${WL0_STATUS}" ] && [ "down" = "${WL2_STATUS}" ]; then
				echo "wifi led on from UI ACtion" > /dev/console
				echo "wifi_led_on" > /proc/bdutil/leds
				syscfg set wifi_led_status "up"
			else
				PRE_WL1_STATUS="${WL1_STATUS}"
				PRE_WL0_STATUS="${WL0_STATUS}"
				PRE_WL2_STATUS="${WL2_STATUS}"
				syscfg set pre_wl1_status "${PRE_WL1_STATUS}" 
				syscfg set pre_wl0_status "${PRE_WL0_STATUS}" 
				syscfg set pre_wl2_status "${PRE_WL2_STATUS}" 
			fi
		elif [ "pressed" = "${PBC_STATUS}" ]; then
			echo "wifi led on from wifi button" > /dev/console
			syscfg set wl2_state down
			syscfg set wl1_state down
			syscfg set wl0_state down
			syscfg set wifi_led_status "up"
			sysevent set wifi_button-status released
		fi
	else
		if [ "released" = "${PBC_STATUS}" ] || [ "" = "${PBC_STATUS}" ]; then
			if [ "up" = "${WL1_STATUS}" ] || [ "up" = "${WL0_STATUS}" ] || [ "up" = "${WL2_STATUS}" ]; then
				echo "wifi led off from UI Action" > /dev/console
				echo "wifi_led_off" > /proc/bdutil/leds
				syscfg set wifi_led_status "down"
				PRE_WL1_STATUS="${WL1_STATUS}"
				PRE_WL0_STATUS="${WL0_STATUS}"
				PRE_WL2_STATUS="${WL2_STATUS}"
				syscfg set pre_wl1_status "${PRE_WL1_STATUS}" 
				syscfg set pre_wl0_status "${PRE_WL0_STATUS}" 
				syscfg set pre_wl2_status "${PRE_WL2_STATUS}" 
			else
				echo "wifi_led_on" > /proc/bdutil/leds
			fi
		elif [ "pressed" = "${PBC_STATUS}" ]; then 
			echo "wifi led off from wifi button" > /dev/console
			PRE_WL1_STATUS=`syscfg get pre_wl1_status`
			PRE_WL0_STATUS=`syscfg get pre_wl0_status`
			PRE_WL2_STATUS=`syscfg get pre_wl2_status`
			syscfg set wl1_state "${PRE_WL1_STATUS}"
			syscfg set wl0_state "${PRE_WL0_STATUS}"
			syscfg set wl2_state "${PRE_WL2_STATUS}"
			syscfg set wifi_led_status "down"
			sysevent set wifi_button-status released
		fi
	fi
else
	if [ "down" = "${LED_STATUS}" ]; then
		if [ "released" = "${PBC_STATUS}" ] || [ "" = "${PBC_STATUS}" ]; then
			if [ "down" = "${WL1_STATUS}" ] && [ "down" = "${WL0_STATUS}" ]; then
				echo "wifi led on from UI ACtion" > /dev/console
				echo "wifi_led_on" > /proc/bdutil/leds
				syscfg set wifi_led_status "up"
			else
				PRE_WL1_STATUS="${WL1_STATUS}"
				PRE_WL0_STATUS="${WL0_STATUS}"
				syscfg set pre_wl1_status "${PRE_WL1_STATUS}" 
				syscfg set pre_wl0_status "${PRE_WL0_STATUS}" 
			fi
		elif [ "pressed" = "${PBC_STATUS}" ]; then
			echo "wifi led on from wifi button" > /dev/console
			echo "wifi_led_on" > /proc/bdutil/leds
			syscfg set wl1_state down
			syscfg set wl0_state down
			syscfg set wifi_led_status "up"
			sysevent set wifi_button-status released
		fi
	else
		if [ "released" = "${PBC_STATUS}" ] || [ "" = "${PBC_STATUS}" ]; then
			if [ "up" = "${WL1_STATUS}" ] || [ "up" = "${WL0_STATUS}" ]; then
				echo "wifi led off from UI Action" > /dev/console
				echo "wifi_led_off" > /proc/bdutil/leds
				syscfg set wifi_led_status "down"
				PRE_WL1_STATUS="${WL1_STATUS}"
				PRE_WL0_STATUS="${WL0_STATUS}"
				syscfg set pre_wl1_status "${PRE_WL1_STATUS}" 
				syscfg set pre_wl0_status "${PRE_WL0_STATUS}" 
			else
				echo "wifi_led_on" > /proc/bdutil/leds
			fi
		elif [ "pressed" = "${PBC_STATUS}" ]; then 
			echo "wifi led off from wifi button" > /dev/console
			echo "wifi_led_off" > /proc/bdutil/leds
			PRE_WL1_STATUS=`syscfg get pre_wl1_status`
			PRE_WL0_STATUS=`syscfg get pre_wl0_status`
			syscfg set wl1_state "${PRE_WL1_STATUS}"
			syscfg set wl0_state "${PRE_WL0_STATUS}"
			syscfg set wifi_led_status "down"
			sysevent set wifi_button-status released
		fi
	fi
fi
syscfg commit
