#!/bin/sh
echo [$0]: $1 ... > /dev/console
if [ "$1" = "start" ]; then
	event "STATUS.READY"            add "usockc /var/gpio_ctrl POWER_LED_GREEN_ON"
	event "STATUS.CRITICAL"         add "usockc /var/gpio_ctrl POWER_LED_GREEN_BLINK_NORMAL"
	event "STATUS.RECOVER"         add "usockc /var/gpio_ctrl POWER_LED_GREEN_BLINK_SLOW"

	event "STATUS.GREEN"            add "usockc /var/gpio_ctrl POWER_LED_GREEN_ON"
	event "STATUS.GREEBBLINK"       add "usockc /var/gpio_ctrl POWER_LED_GREEN_BLINK_SLOW"

	event "STATUS.AMBER"            add "usockc /var/gpio_ctrl POWER_LED_AMBER_ON"
	event "STATUS.AMBERBLINK"       add "usockc /var/gpio_ctrl POWER_LED_GREEN_BLINK_SLOW"

	event "WLANLED.OFF"		add "usockc /var/gpio_ctrl WLAN0_LED_GREEN_OFF"
	event "WLANLED.OFF"		insert "usockc /var/gpio_ctrl WLAN1_LED_GREEN_OFF"
	
	event "WPS.INPROGRESS"		add "usockc /var/gpio_ctrl WPS_LED_GREEN_BLINK_NORMAL"
	event "WPS.SUCCESS"		add "usockc /var/gpio_ctrl WPS_LED_SUCCESS"
	event "WPS.OVERLAP"		add "usockc /var/gpio_ctrl WPS_LED_GREEN_ON"
	event "WPS.ERROR"		add "usockc /var/gpio_ctrl WPS_LED_GREEN_OFF"
	event "WPS.NONE"		add "usockc /var/gpio_ctrl WPS_LED_GREEN_OFF"

#    event "STATUS.READY"        add "usockc /var/gpio_ctrl STATUS_GREEN"
#    event "STATUS.CRITICAL"     add "usockc /var/gpio_ctrl STATUS_AMBER_BLINK"
#    event "STATUS.NOTREADY"     add "usockc /var/gpio_ctrl STATUS_AMBER"
#    event "STATUS.GREEN"        add "usockc /var/gpio_ctrl STATUS_GREEN"
#    event "STATUS.GREEBBLINK"   add "usockc /var/gpio_ctrl STATUS_GREEN_BLINK"
#    event "STATUS.AMBER"        add "usockc /var/gpio_ctrl STATUS_AMBER"
#	event "INET.CONNECTED"		add "usockc /var/gpio_ctrl INET_GREEN"
#	event "INET.DISCONNECTED"	add "usockc /var/gpio_ctrl INET_AMBER"
#	event "WAN-1.CONNECTED"		add "usockc /var/gpio_ctrl INET_GREEN"
#	event "WAN-1.PPP.ONDEMAND"  add "usockc /var/gpio_ctrl INET_AMBER_BLINK"
#	event "WAN-1.DISCONNECTED"  add "usockc /var/gpio_ctrl INET_AMBER"

#	event "WPS.INPROGRESS"		add "usockc /var/gpio_ctrl WPS_IN_PROGRESS"
#	event "WPS.SUCCESS"			add "usockc /var/gpio_ctrl WPS_SUCCESS"
#	event "WPS.OVERLAP"			add "usockc /var/gpio_ctrl WPS_OVERLAP"
#	event "WPS.ERROR"			add "usockc /var/gpio_ctrl WPS_ERROR"
#	event "WPS.NONE"			add "usockc /var/gpio_ctrl WPS_NONE"
#	event "WLAN.CONNECTED"      add "usockc /var/gpio_ctrl WLAN_ENABLED"
#	event "WLAN.DISCONNECTED"   add "usockc /var/gpio_ctrl WLAN_DISABLED"
fi
