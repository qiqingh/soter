#!/bin/sh
image_sign=`cat /etc/config/image_sign`

case "$1" in
start)
	echo "Mounting proc and var ..."
	mount -t proc none /proc
	mount -t sysfs none /sys
	mount -t ramfs ramfs /var
	mkdir -p /var/etc /var/log /var/run /var/state /var/tmp /var/etc/ppp /var/etc/config
	echo -n > /var/etc/resolv.conf
	echo -n > /var/TZ

	# UNIX 98 pty
	mknod -m666 /dev/pts/0 c 136 0
	mknod -m666 /dev/pts/1 c 136 1

	#  syslogd_2007_02_02 , Jordan recover log message
	#  syslogd_2008_03_03.allen
	touch /var/log/messages
	#echo "***************  |  SYS:001" > /var/log/messages	# marked Jordan_2007_01_15
	#echo "" > /var/log/messages	# added by syslogd_2007_01_23

	echo "Inserting modules ..." > /dev/console
	echo "Inserting Rebootm ..." > /dev/console
	insmod /lib/modules/rebootm.ko
	# ethernet driver
	echo "Inserting Cavium ethernet ..." > /dev/console
	insmod /lib/modules/ethernet.ko
	echo "Inserting gpio ..." > /dev/console
	insmod /lib/modules/gpio.ko
	[ "$?" = "0" ] && mknod /dev/gpio c 101 0 && echo "done."
	gpioc -o x 3
	gpioc -w x 3
	# wireless driver

	# get the country code for madwifi, default is fcc.
	ccode=`devdata get -e countrycode`
	[ "$ccode" = "" ] && ccode="840"

	env_wlan=`devdata get -e wlanmac`
	[ "$env_wlan" = "" ] && env_wlan="00:13:10:d1:00:02"

	# prepare db...
	echo "Start xmldb ..." > /dev/console
	xmldb -n $image_sign -t > /dev/console &
	sleep 1
	/etc/scripts/misc/profile.sh get
	/etc/templates/timezone.sh set
	/etc/templates/logs.sh

	# bring up network devices
	env_wan=`devdata get -e wanmac`
	[ "$env_wan" = "" ] && env_wan="00:13:10:d1:00:01"
	ifconfig eth0 hw ether $env_wan up
	rgdb -i -s /runtime/wan/inf:1/mac "$env_wan"

	# bring up loopback interface
	ifconfig lo up

	brctl addbr br0 	> /dev/console
	brctl stp br0 off	> /dev/console
	brctl setfd br0 0	> /dev/console
	;;
stop)
	umount /tmp
	umount /proc
	umount /var
	;;
esac
