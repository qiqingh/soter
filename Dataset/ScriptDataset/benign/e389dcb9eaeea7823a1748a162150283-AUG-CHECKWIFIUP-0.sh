#!/bin/sh
echo [$0] $1 $2...
enable24=$1
enable5=$2

sleep 25

hostapd_daemon=`ps | grep -v "grep" | grep "hostapd"`
wlan0_up=`ifconfig | grep -v "grep" | grep "wlan0"`
wlan1_up=`ifconfig | grep -v "grep" | grep "wlan1"`

sleep 1

need_restart=0

if [ "$hostapd_daemon" == "" ] ; then
	need_restart=1
fi

if [ "$enable24" == "1" -a "$wlan1_up" == "" ] ; then
	need_restart=1
fi


if [ "$enable5" == "1" -a "$wlan0_up" == "" ] ; then
	need_restart=1
fi

if [ "$need_restart" == "1" ] ; then
	echo "need start service----" >/dev/console
	service PHYINF.WIFI restart
fi
