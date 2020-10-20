#!/bin/sh
echo "boot_success" > /proc/bdutil/leds
sleep 10

#kill MU detect process
MU_PID=`sysevent get MU_monitor_PID`
if [ "${MU_PID}" != "" ]; then
	kill ${MU_PID}
fi

if [ -f /etc/init.d/service_wifi/wifi_button.sh ]; then
		/etc/led/manage_wan_led.sh&
		/etc/led/MU-monitor.sh&
		/etc/init.d/service_wifi/wifi_button.sh&
fi

echo "`date` LED $0 $1 $2 $3" >> /var/log/messages
