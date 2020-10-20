#!/bin/sh

UPNPC_SH=/etc/upnpc.sh

op_mode=`flash get OP_MODE | cut -f2 -d=`
wlan0_mode=`flash get WLAN0_MODE | cut -f2 -d="`
repeater=`flash get REPEATER_ENABLED1 | cut -f2 -d="`

if [ $op_mode == 1 ] && [ $wlan0_mode == 0 ] && [ $repeater == 0 ]; then
	desc=`flash get HW_WLAN0_SSID | cut -f2 -d \"`
	$UPNPC_SH $desc br0 22400 22800 80 tcp
else
	echo not in AP mode. do nothing with upnpc 
fi





