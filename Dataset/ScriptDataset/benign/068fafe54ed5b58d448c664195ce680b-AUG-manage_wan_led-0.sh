#!/bin/sh
#
# Manages WAN LED
#
# wan_a is amber
# wan_b is white
#
# If link is down, flash amber (physical connection problem)
# If link is up, but no protocol connectivity, flash white (establishing link)
# if link is up and protocol is up, solid white
#

LED_CTRL=/proc/bdutil/leds

#if [ ! -e $LED_CTRL ]
#then
    #exit 0
#fi

# If Belkin ICC (Internet Connection Checking) is disabled, the as long as the
# WAN proto is up, then it will be solid white
#
 
SetUp=`syscfg get User_Accepts_WiFi_Is_Unsecure`
#keep solid before set up
if [ "1" != "$SetUp" ]; then
#echo default-on > /sys/class/leds/pwr/trigger
#echo "wan=on" > $LED_CTRL
/etc/led/power_led_control.sh on
fi
 
while [ "1" != "$SetUp" ]; do
sleep 2
SetUp=`syscfg get User_Accepts_WiFi_Is_Unsecure`
done

link=`sysevent get phylink_wan_state`
if [ "$link" == "down" ]
then
    # link down
    #echo "wan=altblink" > $LED_CTRL
    /etc/led/power_led_control.sh blink_167
    exit 0
fi

# in bridge mode, only check wan link up/down status
bridge_mode=`syscfg get bridge_mode`
wifi_bridge_mode=`syscfg get wifi_bridge::mode`
if [ "$bridge_mode" != "0" -a "$wifi_bridge_mode" != "1" -a "$wifi_bridge_mode" != "2" ]
then
    #echo "wan=on" > $LED_CTRL
    /etc/led/power_led_control.sh on
    exit 0
fi

wan_status=`sysevent get wan-status`
if [ "$wan_status" != "started" ]
then
    # link up but protocol down
    #echo "wan=blink" > $LED_CTRL
    /etc/led/power_led_control.sh blink_167
    exit 0
fi

state=`sysevent get icc_internet_state`
if [ "$state" != "up" ]; then
    # link up, protocol up, but internet down
    #echo "wan=alton" > $LED_CTRL
    /etc/led/power_led_control.sh on
    exit 0
fi
   
# link up, protocol up, and internet up
#echo "wan=on" > $LED_CTRL
/etc/led/power_led_control.sh on

