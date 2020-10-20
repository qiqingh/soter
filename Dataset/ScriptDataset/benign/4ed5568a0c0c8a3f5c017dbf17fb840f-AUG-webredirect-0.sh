#!/bin/sh
echo [$0] $1 ... > /dev/console
TROOT=`rgdb -i -g /runtime/template_root`
[ "$TROOT" = "" ] && TROOT="/etc/templates"
case "$1" in
start|restart)
	[ -f /var/run/webredirect_stop.sh ] && sh /var/run/webredirect_stop.sh > /dev/console
	rgdb -A $TROOT/webredirect_start.php > /var/run/webredirect_start.sh
	rgdb -A $TROOT/webredirect_stop.php > /var/run/webredirect_stop.sh
	sh /var/run/webredirect_start.sh > /dev/console
	;;
stop)
	if [ -f /var/run/webredirect_stop.sh ]; then
		sh /var/run/webredirect_stop.sh > /dev/console
		rm -f /var/run/webredirect_stop.sh
	fi
	;;
*)
	echo "usage: $0 {start|stop|restart}"
	;;
esac
