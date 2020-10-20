#!/bin/sh

#
# Broadcom et command
# et -i eth0 robowr <page> <address> value
#

echo "led_can_turn_on" > /proc/bdutil/leds

if [ -f /etc/init.d/service_wifi/wifi_button.sh ]; then
		/etc/init.d/service_wifi/wifi_button.sh
fi

if [ -f /etc/init.d/service_wifi/wifi_button.sh ]; then
		/etc/led/manage_wan_led.sh
fi

#Must kill MU-monitor.sh and restart script
#to turn on mu-mimo lights after 
#user has flipped the LED acitvity lights from "off" -> "on"
killall -q MU-monitor.sh
/etc/led/MU-monitor.sh&

et -i eth0 robowr 0x00 0x18 0x1ff
et -i eth0 robowr 0x00 0x1a 0x1ff

#control external switch
et -i eth0 erobowr 0x00 0x18 0x1ff
et -i eth0 erobowr 0x00 0x1a 0x1ff

echo "`date` LED $0 $1 $2 $3" >> /var/log/messages

