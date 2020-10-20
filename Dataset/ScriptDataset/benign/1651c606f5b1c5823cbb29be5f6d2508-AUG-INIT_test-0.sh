#!/bin/sh
mfc_enabled=`mfc mode state|grep "enabled"`
if [ "$mfc_enabled" != "" ] ; then
	echo "mfc mode is enabled"
	return 
fi

sleep 150

xmldb_daemon=`ps | grep -v "grep" | grep "xmldb"`
servd_daemon=`ps | grep -v "grep" | grep "servd"`
httpd_daemon=`ps | grep -v "grep" | grep "httpd"`
gpiod_daemon=`ps | grep -v "grep" | grep "gpiod"`
wlan0_startd=`ifconfig |grep "wlan0"`
wlan1_startd=`ifconfig |grep "wlan1"`


service_layout=`service LAYOUT status`
service_24=`service PHYINF.BAND24G-1.1 status`
service_5g=`service PHYINF.BAND5G-1.1 status`
service_phy=`service PHYINF.WIFI status`

if [ "$service_layout" != "running" ] ; then
	echo "layour start failed"
	reboot
fi

if [ "$service_phy" != "running" ] ; then
	reboot
fi

if [ "$xmldb_daemon" == "" -o  "$servd_daemon" == ""  -o  "$httpd_daemon" == "" -o  "$gpiod_daemon" == "" ] ; then
	reboot
fi

wlan0_enabled="/var/run/BAND24G-1.1.UP"
if [  -e $wlan0_enabled  ] ; then
	if [ "$wlan0_startd" == "" ] ; then
		echo "wlan0 start failed"
		reboot
	fi

	if [ "$service_24" != "running" ] ; then
		reboot
	fi


fi

wlan1_enabled="/var/run/BAND5G-1.1.UP"
if [  -e $wlan1_enabled  ] ; then
	if [ "$wlan1_startd" == "" ] ; then
		echo "wlan1 start failed"
		reboot
	fi

	if [ "$service_5g" != "running" ] ; then
		reboot
	fi
fi
