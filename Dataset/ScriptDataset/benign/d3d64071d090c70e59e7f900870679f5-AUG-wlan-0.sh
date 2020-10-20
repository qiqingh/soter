#!/bin/sh
echo [$0] ... > /dev/console
TROOT=`rgdb -i -g /runtime/template_root`
[ "$TROOT" = "" ] && TROOT="/etc/templates"
case "$1" in
start|restart)
rgdb -A /etc/templates/wlan_servd.php > /var/run/wlan_servd_start.sh
sh /var/run/wlan_servd_start.sh
	;;
stop)
service WLAN stop
	;;
*)
	echo "usage: wlan.sh {start|stop|restart}" > /dev/console
	echo "       if option "a" or "g" are not give," > /dev/console
	echo "       both wlan would be start|stop|restart." > /dev/console
	;;
esac
