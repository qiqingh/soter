#!/bin/sh
echo [$0] ... > /dev/console
TROOT=`rgdb -i -g /runtime/template_root`
[ "$TROOT" = "" ] && TROOT="/etc/templates"

case "$1" in
start|restart)
rgdb -A $TROOT/netbios_run.php -V generate_start=1 > /var/run/netbios_start.sh
sh /var/run/netbios_start.sh > /dev/console
esac

