#!/bin/sh
LED_STATUS=`syscfg get wifi_led_status`
WL1_STATUS=`syscfg get wl1_state`
WL0_STATUS=`syscfg get wl0_state`
WL1_GUEST_ENABLED=`syscfg get wl1_guest_enabled`
WL0_GUEST_ENABLED=`syscfg get wl0_guest_enabled`
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
				PRE_WL1_GUEST_ENABLED="${WL1_GUEST_ENABLED}"
				PRE_WL0_GUEST_ENABLED="${WL0_GUEST_ENABLED}"
				syscfg set pre_wl1_status "${PRE_WL1_STATUS}" 
				syscfg set pre_wl0_status "${PRE_WL0_STATUS}" 
				syscfg set pre_wl2_status "${PRE_WL2_STATUS}" 
				syscfg set pre_wl1_guest_enabled "${PRE_WL1_GUEST_ENABLED}" 
				syscfg set pre_wl0_guest_enabled "${PRE_WL0_GUEST_ENABLED}" 
			fi
		elif [ "pressed" = "${PBC_STATUS}" ]; then
			echo "wifi led on from wifi button" > /dev/console
			syscfg set wl2_state down
			syscfg set wl1_state down
			syscfg set wl0_state down
			syscfg set wl1_guest_enabled 0
			syscfg set wl0_guest_enabled 0
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
				PRE_WL1_GUEST_ENABLED="${WL1_GUEST_ENABLED}"
				PRE_WL0_GUEST_ENABLED="${WL0_GUEST_ENABLED}"
				syscfg set pre_wl1_status "${PRE_WL1_STATUS}" 
				syscfg set pre_wl0_status "${PRE_WL0_STATUS}" 
				syscfg set pre_wl2_status "${PRE_WL2_STATUS}" 
				syscfg set pre_wl1_guest_enabled "${PRE_WL1_GUEST_ENABLED}" 
				syscfg set pre_wl0_guest_enabled "${PRE_WL0_GUEST_ENABLED}" 
			else
				echo "wifi_led_on" > /proc/bdutil/leds
			fi
		elif [ "pressed" = "${PBC_STATUS}" ]; then 
			echo "wifi led off from wifi button" > /dev/console
			PRE_WL1_STATUS=`syscfg get pre_wl1_status`
			PRE_WL0_STATUS=`syscfg get pre_wl0_status`
			PRE_WL2_STATUS=`syscfg get pre_wl2_status`
			PRE_WL1_GUEST_ENABLED=`syscfg get pre_wl1_guest_enabled`
			PRE_WL0_GUEST_ENABLED=`syscfg get pre_wl0_guest_enabled`
			syscfg set wl1_state "${PRE_WL1_STATUS}"
			syscfg set wl0_state "${PRE_WL0_STATUS}"
			syscfg set wl2_state "${PRE_WL2_STATUS}"
			syscfg set wl1_guest_enabled "${PRE_WL1_GUEST_ENABLED}"
			syscfg set wl0_guest_enabled "${PRE_WL0_GUEST_ENABLED}"
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
				PRE_WL1_GUEST_ENABLED="${WL1_GUEST_ENABLED}"
				PRE_WL0_GUEST_ENABLED="${WL0_GUEST_ENABLED}"
				syscfg set pre_wl1_status "${PRE_WL1_STATUS}" 
				syscfg set pre_wl0_status "${PRE_WL0_STATUS}" 
				syscfg set pre_wl1_guest_enabled "${PRE_WL1_GUEST_ENABLED}" 
				syscfg set pre_wl0_guest_enabled "${PRE_WL0_GUEST_ENABLED}" 
			fi
		elif [ "pressed" = "${PBC_STATUS}" ]; then
			echo "wifi led on from wifi button" > /dev/console
			echo "wifi_led_on" > /proc/bdutil/leds
			syscfg set wl1_state down
			syscfg set wl0_state down
			syscfg set wl1_guest_enabled 0
			syscfg set wl0_guest_enabled 0
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
				PRE_WL1_GUEST_ENABLED="${WL1_GUEST_ENABLED}"
				PRE_WL0_GUEST_ENABLED="${WL0_GUEST_ENABLED}"
				syscfg set pre_wl1_status "${PRE_WL1_STATUS}" 
				syscfg set pre_wl0_status "${PRE_WL0_STATUS}" 
				syscfg set pre_wl1_guest_enabled "${PRE_WL1_GUEST_ENABLED}" 
				syscfg set pre_wl0_guest_enabled "${PRE_WL0_GUEST_ENABLED}" 
			else
				echo "wifi_led_on" > /proc/bdutil/leds
			fi
		elif [ "pressed" = "${PBC_STATUS}" ]; then 
			echo "wifi led off from wifi button" > /dev/console
			echo "wifi_led_off" > /proc/bdutil/leds
			PRE_WL1_STATUS=`syscfg get pre_wl1_status`
			PRE_WL0_STATUS=`syscfg get pre_wl0_status`
			PRE_WL1_GUEST_ENABLED=`syscfg get pre_wl1_guest_enabled`
			PRE_WL0_GUEST_ENABLED=`syscfg get pre_wl0_guest_enabled`
			syscfg set wl1_state "${PRE_WL1_STATUS}"
			syscfg set wl0_state "${PRE_WL0_STATUS}"
			syscfg set wl1_guest_enabled "${PRE_WL1_GUEST_ENABLED}"
			syscfg set wl0_guest_enabled "${PRE_WL0_GUEST_ENABLED}"
			syscfg set wifi_led_status "down"
			sysevent set wifi_button-status released
		fi
	fi
fi
syscfg commit
